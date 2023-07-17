import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:communati/getting_started/verification.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../util/gradient_text.dart';
import '../util/hexcolor.dart';
import 'login.dart';

class JoinNow extends StatefulWidget {
  const JoinNow({super.key});

  static String verify = "";

  @override
  State<JoinNow> createState() => _JoinNowState();
}

class _JoinNowState extends State<JoinNow> {
  var phoneNum = "";
  var countryCode = "+91";

  Widget duringOtpSending = const Text(
    "Get OTP",
    style: TextStyle(
        fontSize: 21.07,
        color: Colors.white,
        fontFamily: 'JosefinSans'
    ),
  );




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : false,
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.only(top : 50.0),
              child: GradientText(
                'Join Now',
                style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'JosefinSans'
                ),
                gradient: LinearGradient(colors: [
                  HexColor("#ED1C24"),HexColor("#FB9F40")
                ]),
              ),
            ),
            const Text(
              "Let’s get you signed up !",
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
            Container(
              height: 56,
              width: 300,
              decoration: BoxDecoration(
                color: HexColor("#F5F5F5"),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0,right: 16),
                    child: Container(
                      height: 40,
                      width: 68,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: DropdownButton<String>(
                          value: countryCode,
                          items: <String>['+91', '+44', '+1','+61',].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: const TextStyle(fontSize: 15),
                              ),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              countryCode = newValue!;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.phone,
                      onChanged: (value){
                        setState(() {
                          phoneNum = value;
                        });
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Phone Number",
                        hintStyle: TextStyle(
                            fontFamily: 'Manrope',
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: HexColor("#7D7D7D")
                        )
                      ),
                    ),
                  )
                ],
              ),
            ),
            Text(
              "By continuing you agree to app terms &\n         services and privacy policy",
              style: TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'JosefinSans'
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30.0,bottom: 30),
              child: InkWell(
                child: Container(
                  height: 43.89,
                  width: 273,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [HexColor("#ED1C24"),HexColor("#FB9F40")]
                      ),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Center(
                    child: duringOtpSending,
                  ),
                ),
                onTap: () async {
                  bool ans = await checkExsistingNumber(countryCode+phoneNum);
                  if(ans){
                    setState(() {
                      duringOtpSending = const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Please Wait ",
                            style: TextStyle(
                                fontSize: 21.07,
                                color: Colors.white,
                                fontFamily: 'JosefinSans'
                            ),
                          ),
                          CircularProgressIndicator(color: Colors.white,)
                        ],
                      );
                    });
                    await FirebaseAuth.instance.verifyPhoneNumber(
                      phoneNumber: countryCode+phoneNum,
                      verificationCompleted: (PhoneAuthCredential credential) {},
                      verificationFailed: (FirebaseAuthException e) {},
                      codeSent: (String verificationId, int? resendToken) {
                        JoinNow.verify  = verificationId;
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Verification(phoneNum)));
                      },
                      codeAutoRetrievalTimeout: (String verificationId) {},
                    );
                  }



                },
              ),
            ),
            const Text(
              "Already have an account",
              style: TextStyle(
                fontFamily: 'JosefinSans',
                fontWeight: FontWeight.w400,
                fontSize: 16
              ),
            ),
            InkWell(
              child: GradientText(
                'Log In',
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'JosefinSans',
                    decoration: TextDecoration.underline,
                ),
                gradient: LinearGradient(colors: [
                  HexColor("#ED1C24"),HexColor("#FB9F40")
                ]),
              ),
              onTap: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LogIn()));
              },
            ),
            Container(
              height: 40,
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }



  Future<bool> checkExsistingNumber(String phoneNum) async {
    bool ans = true;
    var collection = FirebaseFirestore.instance.collection('users');
    var querySnapshots = await collection.get();
    for (var snapshot in querySnapshots.docs) {
      var documentID = snapshot.id;
      if(documentID == phoneNum){
        setState(() {
          ans = false;
        });
        const snackBar = SnackBar(
            content: Text("This Phone Number has an Account"),
            duration: Duration(seconds: 1),
            backgroundColor: Colors.red
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        break;
      }
    }
    return ans;


  }


}
