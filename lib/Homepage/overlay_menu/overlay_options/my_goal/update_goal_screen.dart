import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:communati/Homepage/My_People/my_people_screen.dart';
import 'package:communati/Homepage/overlay_menu/overlay_options/my_goal/edit_goal.dart';
import 'package:communati/Homepage/overlay_menu/overlay_options/my_goal/update_a_goal.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import '../../../../util/gradient_icon.dart';
import '../../../../util/hexcolor.dart';
import '../../../Settings/settings_screen.dart';
import '../../../homepage.dart';
import 'package:get/get.dart';

class UpdateGoal extends StatefulWidget {
  Map<String ,dynamic> Userdata;
  List<dynamic> GoalDetail;
  UpdateGoal(this.Userdata,this.GoalDetail,{super.key});


  @override
  State<UpdateGoal> createState() => _UpdateGoalState();
}

class _UpdateGoalState extends State<UpdateGoal> {
  User? firebaseUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : false,
      backgroundColor: Colors.white,
      body: Stack(
          children : [
            Padding(
              padding: const EdgeInsets.only(top: 38.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  Stack(
                      children : [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 55.0),
                          child: Container(
                              height: MediaQuery.of(context).size.height-150,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.centerRight,
                                    end: Alignment.centerLeft,
                                    colors: [HexColor("#FB9F40").withOpacity(0.6),HexColor("#ED1C24").withOpacity(0.6)]
                                ),
                                borderRadius: const BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 15.0),
                                child: SizedBox(
                                  height: MediaQuery.of(context).size.width - 200,
                                  child: ListView.builder(
                                      itemCount: widget.GoalDetail.length,
                                      itemBuilder: (BuildContext context,int index){
                                        return MyGoalInfoCard(index,context);
                                      }
                                  ),
                                ),
                              )
                          ),
                        ),
                        Positioned(
                          top: MediaQuery.of(context).size.height - 210,
                          left: MediaQuery.of(context).size.width - 110,
                          child: InkWell(
                            child: Container(
                              height: 53,
                              width: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                gradient: LinearGradient(
                                    colors: [HexColor("#FB9F40"),HexColor("#ED1C24")]
                                ),
                                boxShadow: const [
                                  BoxShadow(
                                      color: Colors.grey, //New
                                      blurRadius: 5.0,
                                      offset: Offset(0, 0))
                                ],
                              ),
                              child: const Center(
                                child: Text(
                                  "Update Goal",
                                  style: TextStyle(
                                    fontFamily: 'JosefinSans',
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white
                                  ),
                                ),
                              ),
                            ),
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateAGoal(widget.Userdata,widget.GoalDetail[0]["Title"])));
                            },
                          ),
                        )
                      ]

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
                              padding: const EdgeInsets.only(right: 10.0),
                              child: InkWell(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => MyPeopleScreen(widget.Userdata)));
                                  },
                                  child: const Icon(Icons.people_outline,size: 35)),
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
                                gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [HexColor("#FB9F40").withOpacity(0.8),HexColor("#ED1C24").withOpacity(0.8)]
                                )
                            ),
                            child: const Icon(Icons.perm_identity_rounded,size: 35,color: Colors.white,),
                          ),
                          onTap: (){
                            Get.offAll(() => Homepage(widget.Userdata));
                          },
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


  Widget MyGoalInfoCard(int index, BuildContext context){
    return Container(
      margin: const EdgeInsets.only(left: 16,right: 16,bottom: 10,top: 10),
      width: MediaQuery.of(context).size.width,
      // height: 220,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: HexColor("#F8F8F8"),
        boxShadow: const [
          BoxShadow(
              color: Colors.grey, //New
              blurRadius: 1.0,
              offset: Offset(0, 0))
        ],
      ),
      child: Column(
        children: [
          if(widget.GoalDetail[index]["Title"] != null)
            Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Text(
                  "${DateTime.parse(widget.GoalDetail[index]["Date"]).day.toString()}/${DateTime.parse(widget.GoalDetail[index]["Date"]).month.toString()}/${DateTime.parse(widget.GoalDetail[index]["Date"]).year.toString()}",
                  style: const TextStyle(
                    fontFamily: 'JosefinSans',
                    fontSize: 15,

                  ),
                ),
              ),

              PopupMenuButton<int>(
                icon: Icon(Icons.more_horiz,color: Colors.grey,),
                iconSize: 25,
                itemBuilder: (context) => [
                  const PopupMenuItem(
                      value: 1,
                      child: Center(
                        child: Text(
                          "Edit",
                          style: TextStyle(
                              fontFamily: 'JosefinSans',
                              fontWeight: FontWeight.w500,
                              fontSize: 12
                          ),
                        ),
                      )
                  ),
                  const PopupMenuItem(
                      value: 2,
                      child: Center(
                        child: Text(
                          "Delete",
                          style: TextStyle(
                              fontFamily: 'JosefinSans',
                              fontWeight: FontWeight.w500,
                              fontSize: 12
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
                onSelected: (value) async {
                  if(value == 1){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => EditGoal(widget.Userdata, widget.GoalDetail[index],index,widget.GoalDetail[0]['Title'])));
                  }
                  if(value == 2){
                    final storageRef = FirebaseStorage.instance.ref();
                    final desertRef = storageRef.child("${widget.Userdata['username']}/${widget.GoalDetail[index]['Date']}");
                    await desertRef.delete();

                    var _goalDetail = widget.GoalDetail;
                    _goalDetail.removeAt(index);
                    setState(() {
                      widget.GoalDetail = _goalDetail;
                    });

                    var db = FirebaseFirestore.instance;
                    db.collection("users_goals").doc('${widget.Userdata['username']}').update({
                      widget.GoalDetail[0]['Title'] : _goalDetail,
                    });


                  }
                },
              ),
            ],
          ),
          const Divider(thickness: 1,),
          if(widget.GoalDetail[index]["Photo"] != null)
            Padding(
            padding: const EdgeInsets.all(8.0),
            child: CachedNetworkImage(
              imageUrl: widget.GoalDetail[index]["Photo"],
              maxHeightDiskCache: 300,
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  CircularProgressIndicator(value: downloadProgress.progress),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          if(widget.GoalDetail[index]["Description"] != null)
            Container(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.only(left: 12.0,right: 12,top: 8,bottom: 30),
              child: Text(
                widget.GoalDetail[index]["Description"],
                style: TextStyle(
                  fontFamily: 'JosefinSans',
                  fontSize: 15,
                ),
              ),
            ),
          )
        ],
      )
    );
  }
}
