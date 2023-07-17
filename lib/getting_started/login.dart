import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:communati/Homepage/homepage.dart';
import 'package:communati/getting_started/join_now.dart';
import 'package:communati/getting_started/login_otp_verify.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import '../util/gradient_text.dart';
import '../util/hexcolor.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {

  late String username;
  late String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : false,
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GradientText(
              'Log In',
              style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'JosefinSans'
              ),
              gradient: LinearGradient(colors: [
                HexColor("#ED1C24"),HexColor("#FB9F40")
              ]),
            ),
            Column(
              children: [
                Container(
                  height: 50,
                  width: 273,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: GradientBoxBorder(
                        gradient: LinearGradient(colors: [HexColor("#ED1C24"),HexColor("#FB9F40")]),
                        width: 1
                    ),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: TextField(
                      onChanged: (value){
                        setState(() {
                          username = value;
                        });
                      },
                      cursorColor: Colors.red,
                      decoration: InputDecoration(
                        hintText: 'Username / Phone No.',
                        hintStyle: TextStyle(
                            fontFamily: 'JosefinSans',
                            color: Colors.red,
                            fontSize: 14,
                            fontWeight: FontWeight.w300
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                        ),

                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30,),
                Container(
                  height: 50,
                  width: 273,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: GradientBoxBorder(
                        gradient: LinearGradient(colors: [HexColor("#ED1C24"),HexColor("#FB9F40")]),
                        width: 1
                    ),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: TextField(
                      onChanged: (value){
                        setState(() {
                          password = value;
                        });
                      },
                      cursorColor: Colors.red,
                      decoration: const InputDecoration(
                        hintText: 'Password',
                        hintStyle: TextStyle(
                            fontFamily: 'JosefinSans',
                            color: Colors.red,
                            fontSize: 14,
                            fontWeight: FontWeight.w300
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                        ),

                      ),
                    ),
                  ),
                ),
              ],
            ),
            Text(
              "Forgot Password?",
              style: TextStyle(
                fontFamily: 'JosefinSans',
                fontSize: 14,
                fontWeight: FontWeight.w400
              ),
            ),
            const Center(
              child: Text(
                "By continuing you agree to app terms &\n         services and privacy policy",
                style: TextStyle(
                    fontSize: 7.77,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'JosefinSans'
                ),
              ),
            ),
            InkWell(
              child: Container(
                height: 50,
                width: 273,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [HexColor("#ED1C24"),HexColor("#FB9F40")]
                    ),
                    borderRadius: BorderRadius.circular(10)
                ),
                child: const Center(
                  child: Text(
                    "Log In",
                    style: TextStyle(
                        fontSize: 21.07,
                        color: Colors.white,
                        fontFamily: 'JosefinSans'
                    ),
                  ),
                ),
              ),
              onTap: (){
                _authenticateUser(username,password);
              },
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have an account",
                  style: TextStyle(
                    fontFamily: 'JosefinSans',
                    fontWeight: FontWeight.w400,
                    fontSize: 16
                  ),
                ),
                const SizedBox(height: 20,),
                InkWell(
                  child: GradientText(
                    'Join Now',
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'JosefinSans',
                        decoration: TextDecoration.underline
                    ),
                    gradient: LinearGradient(colors: [
                      HexColor("#ED1C24"),HexColor("#FB9F40")
                    ]),
                  ),
                  onTap: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => JoinNow()));
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void _authenticateUser(String username,String password) {
    const snackBar = SnackBar(
        content: Text("Please Wait.."),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.green
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    print(username);
    print(password);
    var db = FirebaseFirestore.instance;
    var UserCred;
    var Userdata;

    //With PhoneNumber
    final docRef = db.collection("users").doc(username);
    docRef.get().then(
          (DocumentSnapshot doc) {
        setState(() {
          UserCred = doc.data() as Map<String, dynamic>;
        });
        print(UserCred);
      },
    );

    Timer(const Duration(seconds: 1), () {
      if (UserCred != null && UserCred['phoneNumber'] == username &&
          UserCred['password'] == password) {
        Timer(
            const Duration(seconds: 1), () async {
              await FirebaseAuth.instance.verifyPhoneNumber(
                phoneNumber: username,
                verificationCompleted: (PhoneAuthCredential credential) {},
                verificationFailed: (FirebaseAuthException e) {},
                codeSent: (String verificationId, int? resendToken) {
                  var verificationID  = verificationId;
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginOTP(verificationID,UserCred)));
                },
                codeAutoRetrievalTimeout: (String verificationId) {},
              );
            }

        );
      }

      //With Username
      else {
        final docRef = db.collection("login_authentication").doc(username);
        docRef.get().then(
              (DocumentSnapshot doc) {
            setState(() {
              UserCred = doc.data() as Map<String, dynamic>;
            });
          },
        );
        Timer(const Duration(seconds: 1),
                (){
              print(UserCred);
              if (UserCred != null && UserCred['password'] == password) {
                final docRef = db.collection("users").doc(UserCred['phoneNumber']);
                docRef.get().then(
                      (DocumentSnapshot doc) {
                    setState(() {
                      Userdata = doc.data() as Map<String, dynamic>;
                    });
                  },
                );
                Timer(
                    const Duration(seconds: 1),() async {
                      await FirebaseAuth.instance.verifyPhoneNumber(
                        phoneNumber: UserCred['phoneNumber'],
                        verificationCompleted: (PhoneAuthCredential credential) {},
                        verificationFailed: (FirebaseAuthException e) {},
                        codeSent: (String verificationId, int? resendToken) {
                          var verificationID  = verificationId;
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginOTP(verificationID,Userdata)));
                        },
                        codeAutoRetrievalTimeout: (String verificationId) {},
                      );
                    }
                );
              }


              else {
                const snackBar = SnackBar(
                    content: Text("Wrong Username or Password"),
                    duration: Duration(seconds: 1),
                    backgroundColor: Colors.red
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            }
        );

      }
    });


  }
}
