import 'package:communati/util/hexcolor.dart';
import 'package:flutter/material.dart';
import '../util/gradient_text.dart';
import 'login_signin.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({super.key});

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
                'Welcome to the\n   Communati',
                style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'JosefinSans',
                ),
                gradient: LinearGradient(colors: [
                  HexColor("#ED1C24"),HexColor("#FB9F40")
                ]),
              ),
              Image.asset('images/gettingStarted.png'),
              InkWell(
                child: Container(
                  height: 50,
                  width: 311,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [HexColor("#ED1C24"),HexColor("#FB9F40")]
                    ),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: const Center(
                    child: Text(
                      "Get Started",
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontFamily: 'JosefinSans'
                      ),
                    ),
                  ),
                ),
                onTap: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => login_signin()));
                },
              )
            ],
          ),
      )
    );
  }
}
