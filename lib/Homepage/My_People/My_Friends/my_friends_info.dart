import 'package:communati/Homepage/My_People/My_Friends/my_friends_about.dart';
import 'package:communati/Homepage/My_People/My_Friends/my_friends_memories_with.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../util/gradient_icon.dart';
import '../../../util/hexcolor.dart';
import '../../Settings/settings_screen.dart';
import '../../homepage.dart';
import 'package:get/get.dart';
import '../my_people_screen.dart';

class MyFriendsInfo extends StatefulWidget {
  Map<String ,dynamic> Userdata;
  MyFriendsInfo(this.Userdata,{super.key});

  @override
  State<MyFriendsInfo> createState() => _MyFriendsInfoState();
}

class _MyFriendsInfoState extends State<MyFriendsInfo> {
  User? firebaseUser = FirebaseAuth.instance.currentUser;
  int index = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : false,
      backgroundColor: Colors.white,
      body: Stack(
          children : [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 38.0,bottom: 20),
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
                Container(
                  height: 144,
                  width: 144,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage("images/micheal_scott.jpg")
                    ),
                  ),
                ),
                Text(
                  "Micheal Scott",
                  style: TextStyle(
                      fontFamily: 'Dongle',
                      fontWeight: FontWeight.w400,
                      fontSize: 32
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 110,
                      child: Row(
                        children: [
                          Icon(Icons.cake_outlined,size: 20,),
                          Padding(
                            padding: EdgeInsets.only(top: 8.0,left: 2,right: 10),
                            child: Text(
                              "40 year old",
                              style: TextStyle(
                                  fontFamily: 'Dongle',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 22
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    Container(
                      width: 100,
                      child: Row(
                        children: [
                          Icon(Icons.pin_drop_outlined,size: 20,),
                          Padding(
                            padding: EdgeInsets.only(top :8.0),
                            child: Text(
                              "USA",
                              style: TextStyle(
                                  fontFamily: 'Dongle',
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400
                              ),
                            ),
                          )
                        ],
                      ),
                    ),

                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 2.5*MediaQuery.of(context).size.height/5,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40)),
                        gradient: LinearGradient(
                            begin: Alignment.centerRight,
                            end: Alignment.centerLeft,
                            colors: [HexColor("#FB9F40").withOpacity(0.6),HexColor("#ED1C24").withOpacity(0.6)]
                        )
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 20.0,bottom: 10),
                              child: InkWell(
                                onTap: (){
                                  setState(() {
                                    index = 1;
                                  });
                                },
                                child: Container(
                                  width: 146,
                                  height: 44,
                                  decoration: BoxDecoration(
                                    color: HexColor("#FFF5F5"),
                                    borderRadius: BorderRadius.circular(26),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey, //New
                                          blurRadius: 2.0,
                                          offset: (index == 1) ? Offset(6, 4) : Offset(0, 0)
                                      )
                                    ],
                                  ),
                                  child: const Center(
                                    child: Text(
                                      "About Micheal",
                                      style: TextStyle(
                                          fontFamily: 'JosefinSans',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20.0,bottom: 10),
                              child: InkWell(
                                onTap: (){
                                  setState(() {
                                    index = 2;
                                  });
                                },
                                child: Container(
                                  width: 146,
                                  height: 44,
                                  decoration: BoxDecoration(
                                    color: HexColor("#FFF5F5"),
                                    borderRadius: BorderRadius.circular(26),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey, //New
                                          blurRadius: 2.0,
                                          offset: (index == 2) ? Offset(6, 4) : Offset(0, 0)
                                      )
                                    ],
                                  ),
                                  child: const Center(
                                    child: Text(
                                      "Your Memories with\n    Prison Micheal",
                                      style: TextStyle(
                                          fontFamily: 'JosefinSans',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        WidgetSelector(index),
                      ],
                    ),
                  ),
                ),
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
                              child: InkWell(
                                  onTap: (){
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyPeopleScreen(widget.Userdata)));
                                  },
                                  child: Icon(Icons.people_outline,size: 35)
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 10.0),
                              child: InkWell(
                                  onTap: (){
                                    Get.off((MyPeopleScreen(widget.Userdata)));
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
      )
    );
  }

  Widget WidgetSelector(int index){
    if(index == 1){
      return MyFriendsAbout();
    }
    return MyFriendsMemoriesWith();
  }
}
