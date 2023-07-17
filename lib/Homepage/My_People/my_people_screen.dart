import 'package:communati/Homepage/My_People/Add_People/add_people_screen.dart';
import 'package:communati/Homepage/My_People/Chat/chat_screen.dart';
import 'package:communati/Homepage/My_People/My_Friends/my_friends.dart';
import 'package:communati/util/gradient_icon.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import '../../util/hexcolor.dart';
import '../Settings/settings_screen.dart';
import '../homepage.dart';

class MyPeopleScreen extends StatefulWidget {
  Map<String ,dynamic> Userdata;
  MyPeopleScreen(this.Userdata,{super.key});

  @override
  State<MyPeopleScreen> createState() => _MyPeopleScreenState();
}

class _MyPeopleScreenState extends State<MyPeopleScreen> {
  User? firebaseUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : false,
      backgroundColor: Colors.white,
      body: Stack(
          children : [
            Padding(
              padding: const EdgeInsets.only(top: 40.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          width: 129.88,
                          height: 32,
                          child: Image.asset("images/homepage.png")
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width - 100,
                        height: 36,
                        decoration: BoxDecoration(
                          color: HexColor("#F8F8F8"),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 1.0,
                                  offset: Offset(0, 2))
                            ],
                          borderRadius: BorderRadius.circular(10),
                          border: GradientBoxBorder(gradient: LinearGradient(colors: [HexColor("#FB9F40"),HexColor("#ED1C24")]))
                        ),
                        child: Center(
                          child: Text(
                            "Search",
                            style: TextStyle(
                              color: Colors.grey
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ChatScreen()));
                        },
                        child: GradientIcon(
                            Icons.mail_outline,
                            38,
                            LinearGradient(colors: [HexColor("#FB9F40"),HexColor("#ED1C24")]),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0,right: 16),
                    child: InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => AddPeopleScreen(widget.Userdata)));
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 69,
                        decoration: BoxDecoration(
                          border: GradientBoxBorder(gradient: LinearGradient(colors: [HexColor("#FB9F40"),HexColor("#ED1C24")])),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const SizedBox(width: 10,),
                              Text(
                                "Add people",
                                style: TextStyle(
                                  fontFamily: 'JosefinSans',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16
                                ),
                              ),
                              GradientIcon(
                                  Icons.qr_code,
                                  35,
                                  LinearGradient(colors: [HexColor("#FB9F40"),HexColor("#ED1C24")])
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  MyFriends(widget.Userdata),

                ],
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
                              child: Icon(Icons.people_outline,size: 35),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 10.0),
                              child: InkWell(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsScreen(widget.Userdata)));
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
                            Get.offAll(() => Homepage(widget.Userdata));
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
          ]
      ),
    );
  }
}
