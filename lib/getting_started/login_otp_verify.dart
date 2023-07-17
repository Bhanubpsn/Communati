import 'package:communati/getting_started/full_name.dart';
import 'package:communati/getting_started/join_now.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import '../Homepage/homepage.dart';
import '../util/gradient_text.dart';
import '../util/hexcolor.dart';

class LoginOTP extends StatefulWidget {

  var verificationID;
  var Userdata;

  LoginOTP(this.verificationID,this.Userdata, {super.key});


  @override
  State<LoginOTP> createState() => _LoginOTPState();
}

class _LoginOTPState extends State<LoginOTP> {

  final FirebaseAuth auth = FirebaseAuth.instance;
  var code = "";

  Widget duringVerifying = Text(
    "Verify",
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
            Container(
                height: 190,
                width: 195,
                child: Image.asset('images/otp_image.png')
            ),
            GradientText(
              'Verification',
              style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'JosefinSans'
              ),
              gradient: LinearGradient(colors: [
                HexColor("#ED1C24"),HexColor("#FB9F40")
              ]),
            ),
            OtpTextField(
              cursorColor: Colors.red,
              numberOfFields: 6,
              borderColor : Colors.red,
              showFieldAsBox: true,
              onCodeChanged: (value) {
                setState(() {
                  code = value;
                });
              },
              onSubmit: (value){
                setState(() {
                  code = value;
                });
              },// end onSubmit
            ),
            const Text(
              "Didn’t you receive any code?",
              style: TextStyle(
                  fontFamily: 'JosefinSans',
                  fontSize: 16,
                  fontWeight: FontWeight.w400
              ),
            ),
            InkWell(
              child: const Text(
                "Re-send code",
                style: TextStyle(
                    fontFamily: 'JosefinSans',
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    decoration: TextDecoration.underline
                ),
              ),
              onTap: (){},
            ),
            InkWell(
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
                  child: duringVerifying,
                ),
              ),
              onTap: () async {
                setState(() {
                  duringVerifying = const Row(
                      mainAxisAlignment:  MainAxisAlignment.center,
                      children: [
                        Text(
                          "Verifying ",
                          style: TextStyle(
                              fontSize: 21.07,
                              color: Colors.white,
                              fontFamily: 'JosefinSans'
                          ),
                        ),
                        CircularProgressIndicator(color: Colors.white,)
                      ]
                  );
                });
                try{
                  PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: widget.verificationID, smsCode: code);
                  await auth.signInWithCredential(credential);
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => Homepage(widget.Userdata)));
                }
                catch(e){
                  setState(() {
                    duringVerifying = Text(
                      "Verify",
                      style: TextStyle(
                          fontSize: 21.07,
                          color: Colors.white,
                          fontFamily: 'JosefinSans'
                      ),
                    );
                  });
                  const snackBar = SnackBar(
                      content: Text("Incorrect OTP"),
                      duration: Duration(seconds: 1),
                      backgroundColor: Colors.red
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }

              },
            ),
          ],
        ),
      ),
    );
  }
}
