import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import '../../../util/gradient_icon.dart';
import '../../../util/hexcolor.dart';
import '../../Settings/settings_screen.dart';
import '../../homepage.dart';
import '../my_people_screen.dart';

class AddPeopleScreen extends StatelessWidget {
  Map<String ,dynamic> Userdata;
  AddPeopleScreen(this.Userdata,{super.key});

  @override
  Widget build(BuildContext context) {
    User? firebaseUser = FirebaseAuth.instance.currentUser;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 38.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child: GradientIcon(Icons.arrow_back, 32, LinearGradient(colors: [HexColor("#FB9F40"),HexColor("#ED1C24")]))
                        ),
                        Container(
                            width: 129.88,
                            height: 32,
                            child: Image.asset("images/homepage.png")
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 20.0),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Center(
                child: Text(
                  "@Bhanubpsn",
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 30
                  ),
                ),
              ),
              GradientIcon(
                  Icons.qr_code_2_sharp,
                  300,
                  LinearGradient(colors: [HexColor("#FB9F40"),HexColor("#ED1C24")])
              ),
              Center(
                child: Text(
                  "Or",
                  style: TextStyle(
                    fontFamily: 'JosefinSans',
                    fontSize: 16
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0,right: 16,bottom: 100),
                child: InkWell(
                  onTap: (){},
                  child: Container(
                    height: 65,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      border: GradientBoxBorder(gradient: LinearGradient(colors: [HexColor("#FB9F40"),HexColor("#ED1C24")])),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                              const SizedBox(width: 20,),
                              Text(
                                "Share Profile Link",
                                style: TextStyle(
                                  fontFamily: 'JosefinSans',
                                  fontSize: 15
                                ),
                              ),
                              Icon(Icons.file_upload_outlined,size: 30,),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          Positioned(
            top: MediaQuery.of(context).size.height - 90,
            child: Container(
              height: 104,
              color: Colors.transparent,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  Positioned(
                    top: 35,
                    child: Container(
                      height: 60,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey,
                              blurRadius: 1.0,
                              offset: Offset(0, 0))
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 10.0),
                            child: Icon(Icons.people_outline,size: 35),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10.0),
                            child: InkWell(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsScreen(Userdata)));
                                },
                                child: Icon(Icons.settings,size: 35,)
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                      top: 0,
                      left: MediaQuery.of(context).size.width/2 - 37.8,
                      height: 75,
                      width: 75,
                      child: InkWell(
                        child: Container(
                          height: 77,
                          width: 77,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: HexColor("#F8F8F8"),
                            boxShadow: const [
                              BoxShadow(
                                  color: Colors.grey, //New
                                  blurRadius: 2.0,
                                  offset: Offset(0, 2))
                            ],
                          ),
                          child: const Icon(Icons.perm_identity_rounded,size: 35,color: Colors.black,),
                        ),
                        onTap: (){
                          Get.offAll(() => Homepage(Userdata));
                        },
                      )
                  ),
                  Positioned(
                      top: MediaQuery.of(context).size.height/9.2,
                      left: MediaQuery.of(context).size.width/3.5 ,
                      child: Container(
                        height: 6,
                        width: 6,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [HexColor("#FB9F40"),HexColor("#ED1C24")]
                            ),
                            borderRadius: BorderRadius.circular(8)
                        ),
                      )
                  )

                ],
              ),
            ),
          ),

        ],
      ),
    );
  }
}
