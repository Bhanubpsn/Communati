import 'package:communati/getting_started/create_account.dart';
import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import '../util/gradient_text.dart';
import '../util/hexcolor.dart';
import 'login.dart';

class FullName extends StatefulWidget {
  late var phoneNum;
  FullName(this.phoneNum,{super.key});

  static String _fullname = "";

  @override
  State<FullName> createState() => _FullNameState();
}

class _FullNameState extends State<FullName> {
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
            const Text(
              "What is your full name?",
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                fontSize: 16
              ),
            ),
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
                padding: EdgeInsets.only(left: 20.0),
                child: TextField(
                  onChanged: (value){
                    setState(() {
                      FullName._fullname = value;
                    });
                  },
                  cursorColor: Colors.red,
                  decoration: InputDecoration(
                    hintText: 'Full Name',
                    hintStyle: TextStyle(
                      fontFamily: 'JosefinSans',
                      color: Colors.red,
                      fontSize: 14,
                      fontWeight: FontWeight.w400
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
            const Center(
              child: Text(
                "By continuing you agree to app terms &\n         services and privacy policy",
                style: TextStyle(
                    fontSize: 16,
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
                    "Create",
                    style: TextStyle(
                        fontSize: 21.07,
                        color: Colors.white,
                        fontFamily: 'JosefinSans'
                    ),
                  ),
                ),
              ),
              onTap: (){
                if(FullName._fullname.isNotEmpty){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CreateAccount(widget.phoneNum,FullName._fullname)));
                }
                else{
                  const snackBar = SnackBar(
                      content: Text("Name Can't be empty"),
                      duration: Duration(seconds: 1),
                      backgroundColor: Colors.red
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              },
            ),
            Text(
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
          ],
        ),
      ),
    );
  }
}
