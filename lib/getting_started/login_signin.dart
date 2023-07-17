import 'package:communati/getting_started/join_now.dart';
import 'package:flutter/material.dart';
import '../util/gradient_text.dart';
import '../util/hexcolor.dart';
import 'login.dart';

class login_signin extends StatelessWidget {
  const login_signin({super.key});

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
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height/8,
              color: Colors.white,
            ),
            Image.asset('images/gettingStarted.png'),
            const Center(
              child: Text(
                "By continuing you agree to app terms &\n         services and privacy policy",
                style: TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'JosefinSans'
                ),
              ),
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
                child: const Center(
                  child: Text(
                    "Join Now",
                    style: TextStyle(
                        fontSize: 21.07,
                        color: Colors.white,
                        fontFamily: 'JosefinSans'
                    ),
                  ),
                ),
              ),
              onTap: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const JoinNow()));
              },
            ),
            const Text(
              "Already have an account",
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'JosefinSans'
              ),
            ),
            InkWell(
              child: Container(
                height: 43.89,
                width: 273,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(
                        colors: [HexColor("#ED1C24"),HexColor("#FB9F40")]
                    ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(1.5),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Center(
                      child: GradientText(
                        'Log In',
                        style: const TextStyle(
                            fontSize: 21.07,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'JosefinSans'
                        ),
                        gradient: LinearGradient(colors: [
                          HexColor("#ED1C24"),HexColor("#FB9F40")
                        ]),
                      ),
                    ),
                  ),
                ),
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
