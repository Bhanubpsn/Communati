import 'package:communati/Homepage/My_People/my_people_screen.dart';
import 'package:communati/Homepage/Settings/edit_account.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import '../../util/hexcolor.dart';
import '../homepage.dart';

class SettingsScreen extends StatefulWidget {
  Map<String ,dynamic> Userdata;
  SettingsScreen(this.Userdata,{super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  User? firebaseUser = FirebaseAuth.instance.currentUser;
  bool status = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : false,
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0,right: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "Settings",
                        style: TextStyle(
                          fontFamily: 'Dongle',
                          fontSize: 32,
                          fontWeight: FontWeight.w700
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 106,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0,bottom: 8,left: 16,right: 16),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "pause notification",
                                    style: TextStyle(
                                      fontSize: 25,
                                      fontFamily: 'Dongle',
                                      fontWeight: FontWeight.w400
                                    ),
                                  ),
                                  FlutterSwitch(
                                    toggleBorder: Border.all(
                                        color: Colors.black,
                                        width: 2
                                    ),
                                    switchBorder: Border.all(
                                      color: Colors.black,
                                      width: 2.0,
                                    ),
                                    activeColor: Colors.black,
                                    inactiveColor: Colors.white,
                                    width: 30,
                                    height: 20,
                                    toggleSize: 12,
                                    value: status,
                                    borderRadius: 20.0,
                                    padding: 2.0,
                                    onToggle: (val) {
                                      setState(() {
                                        status = val;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                            const Divider(height: 0,thickness: 1.5,),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0,bottom: 8,left: 16,right: 16),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Notification setting",
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontFamily: 'Dongle',
                                        fontWeight: FontWeight.w400
                                    ),
                                  ),
                                  Icon(
                                      Icons.arrow_forward_ios_sharp,
                                      size: 20,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 53*6,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        width: 1,
                        color: Colors.grey
                      )
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0,bottom: 8,left: 16,right: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "What's new",
                                style: TextStyle(
                                    fontSize: 25,
                                    fontFamily: 'Dongle',
                                    fontWeight: FontWeight.w400
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_ios_sharp,
                                size: 20,
                              )
                            ],
                          ),
                        ),
                        const Divider(height: 0,thickness: 1.5,),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0,bottom: 8,left: 16,right: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Community Guidlines",
                                style: TextStyle(
                                    fontSize: 25,
                                    fontFamily: 'Dongle',
                                    fontWeight: FontWeight.w400
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_ios_sharp,
                                size: 20,
                              )
                            ],
                          ),
                        ),
                        const Divider(height: 0,thickness: 1.5,),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0,bottom: 8,left: 16,right: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Terms of Service",
                                style: TextStyle(
                                    fontSize: 25,
                                    fontFamily: 'Dongle',
                                    fontWeight: FontWeight.w400
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_ios_sharp,
                                size: 20,
                              )
                            ],
                          ),
                        ),
                        const Divider(height: 0,thickness: 1.5,),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0,bottom: 8,left: 16,right: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Privacy Policy",
                                style: TextStyle(
                                    fontSize: 25,
                                    fontFamily: 'Dongle',
                                    fontWeight: FontWeight.w400
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_ios_sharp,
                                size: 20,
                              )
                            ],
                          ),
                        ),
                        const Divider(height: 0,thickness: 1.5,),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0,bottom: 8,left: 16,right: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Faq",
                                style: TextStyle(
                                    fontSize: 25,
                                    fontFamily: 'Dongle',
                                    fontWeight: FontWeight.w400
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_ios_sharp,
                                size: 20,
                              )
                            ],
                          ),
                        ),
                        const Divider(height: 0,thickness: 1.5,),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0,bottom: 8,left: 16,right: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Contact us",
                                style: TextStyle(
                                    fontSize: 25,
                                    fontFamily: 'Dongle',
                                    fontWeight: FontWeight.w400
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_ios_sharp,
                                size: 20,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 45.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 53,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          width: 1,
                          color: Colors.grey
                        )
                      ),
                      child: IntrinsicHeight(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0,bottom: 8,left: 16,),
                              child: Text(
                                "Deactivate account",
                                style: TextStyle(
                                  fontFamily: 'Dongle',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 22
                                ),
                              ),
                            ),
                            VerticalDivider(thickness: 1.5,),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0,bottom: 8,left: 16,right: 24),
                              child: InkWell(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => EditAccount()));
                                },
                                child: Text(
                                  "Edit account",
                                  style: TextStyle(
                                      fontFamily: 'Dongle',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 22
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
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
                            child: InkWell(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => MyPeopleScreen(widget.Userdata)));
                                },
                                child: Icon(Icons.people_outline,size: 35)),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10.0),
                            child: Icon(Icons.settings,size: 35,),
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
                          Get.offAll(() => Homepage(widget.Userdata));
                        },
                      )
                  ),
                  Positioned(
                      top: MediaQuery.of(context).size.height/9.2,
                      left: MediaQuery.of(context).size.width/1.44 ,
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
