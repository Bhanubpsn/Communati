import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:communati/Homepage/My_People/my_people_screen.dart';
import 'package:communati/Homepage/Settings/settings_screen.dart';
import 'package:communati/Homepage/overlay_menu/overlay_screen.dart';
import 'package:communati/Homepage/profile_view.dart';
import 'package:communati/Homepage/timeline.dart';
import 'package:communati/getting_started/profile_picture.dart';
import 'package:communati/util/gradient_icon.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import '../util/hexcolor.dart';
import 'package:get/get.dart';

class Homepage extends StatefulWidget {
  Map<String, dynamic> Userdata;
  Homepage(this.Userdata,{super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  bool status = false;


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
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 25.0),
                        child: FlutterSwitch(
                          toggleBorder: Border.all(
                              color: Colors.red,
                              width: 2
                          ),
                          switchBorder: Border.all(
                            color: Colors.red,
                            width: 2.0,
                          ),
                          activeColor: Colors.red,
                          inactiveColor: Colors.white,
                          width: 40,
                          height: 25,
                          toggleSize: 15,
                          value: status,
                          borderRadius: 30.0,
                          // padding: 8.0,
                          onToggle: (val) {
                            setState(() {
                              status = val;
                            });
                          },
                        ),
                      ),
                      Container(
                          width: 129.88,
                          height: 32,
                          child: Image.asset("images/homepage.png")
                      ),
                      PopupMenuButton<int>(
                        offset: Offset(-MediaQuery.of(context).size.width/10, MediaQuery.of(context).size.height/6),
                        icon: GradientIcon(
                            Icons.more_vert,
                            40,
                            LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [HexColor("#FB9F40"),HexColor("#ED1C24")]
                            )
                        ),
                        iconSize: 40,
                        itemBuilder: (context) => [
                          PopupMenuItem(
                              value: 1,
                              child: Padding(
                                padding: const EdgeInsets.only(top : 50.0,bottom: 20),
                                child: Container(
                                  width: 303,
                                  child: const Center(
                                    child: Text(
                                      "My Space",
                                      style: TextStyle(
                                          fontFamily: 'Dongle',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 33
                                      ),
                                    ),
                                  ),
                                ),
                              )
                          ),
                          PopupMenuItem(
                              value: 2,
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: Container(
                                  width: 303,
                                  child: const Center(
                                    child: Text(
                                      "My Life Events",
                                      style: TextStyle(
                                          fontFamily: 'Dongle',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 33
                                      ),
                                    ),
                                  ),
                                ),
                              )
                          ),
                          PopupMenuItem(
                              value: 3,
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: Container(
                                  width: 303,
                                  child: const Center(
                                    child: Text(
                                      "My Memories",
                                      style: TextStyle(
                                          fontFamily: 'Dongle',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 33
                                      ),
                                    ),
                                  ),
                                ),
                              )
                          ),
                          PopupMenuItem(
                              value: 4,
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: Container(
                                  width: 303,
                                  child: const Center(
                                    child: Text(
                                      "My Photos",
                                      style: TextStyle(
                                          fontFamily: 'Dongle',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 33
                                      ),
                                    ),
                                  ),
                                ),
                              )
                          ),
                          PopupMenuItem(
                              value: 5,
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 50),
                                child: Container(
                                  width: 303,
                                  child: const Center(
                                    child: Text(
                                      "My Goal",
                                      style: TextStyle(
                                          fontFamily: 'Dongle',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 33
                                      ),
                                    ),
                                  ),
                                ),
                              )
                          ),
                        ],
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20.0),
                          ),
                        ),
                        color: Colors.orange.shade100,
                        elevation: 2,
                        onSelected: (value) {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => OverlayScreen(widget.Userdata,index :value)));
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 39,),
                  Profile_Timeline_Toogle(status),
                ],
              ),

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
                            child: InkWell(
                                child: Icon(Icons.settings,size: 35,),
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsScreen(widget.Userdata)));
                                },
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
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [HexColor("#FB9F40").withOpacity(0.8),HexColor("#ED1C24").withOpacity(0.8)]
                              )
                          ),
                          child: const Icon(Icons.perm_identity_rounded,size: 35,color: Colors.white,),
                        ),
                      )
                  ),

                ],
              ),
            ),
          ),
        ]
      ),
    );
  }
  
  Widget Profile_Timeline_Toogle(bool status){
    setState(() {
      FirebaseFirestore.instance.collection('users').doc(widget.Userdata['phoneNumber']).get().then(
            (DocumentSnapshot doc) {
          setState(() {
            widget.Userdata = doc.data() as Map<String, dynamic>;
          });
        },
        onError: (e) => print("Error getting document: $e"),
      );
    });
    if(status == false){
      return Timeline(widget.Userdata);
    }
    else{
      return ProfileView(widget.Userdata);
    }
  }
}

