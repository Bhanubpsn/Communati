import 'dart:typed_data';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:communati/Homepage/My_People/my_people_screen.dart';
import 'package:communati/Homepage/overlay_menu/overlay_options/my_goal/upload_goal_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../util/Pick_Image.dart';
import '../../../../util/gradient_icon.dart';
import '../../../../util/hexcolor.dart';
import '../../../Settings/settings_screen.dart';
import '../../../homepage.dart';
import 'package:get/get.dart';
import '../../overlay_screen.dart';

class EditGoal extends StatefulWidget {
  Map<String ,dynamic> Userdata;
  Map<String,dynamic> GoalItem;
  int index;
  String GoalTitle;
  EditGoal(this.Userdata,this.GoalItem,this.index,this.GoalTitle,{super.key});

  @override
  State<EditGoal> createState() => _EditGoalState();
}

class _EditGoalState extends State<EditGoal> {
  User? firebaseUser = FirebaseAuth.instance.currentUser;

  var title;
  var description;
  Widget goalImage = Center(
    child: Column(
      children: [
        Icon(Icons.image_outlined,size: 100,color: Colors.grey,),
        Text(
          "Add Photo",
          style: TextStyle(
              fontFamily: 'JosefinSans',
              fontWeight: FontWeight.w400,
              fontSize: 16,
              color: Colors.grey
          ),
        )
      ],
    ),
  );
  var db = FirebaseFirestore.instance;
  List toBeEditGoal = [];
  Uint8List? _image;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() {
      title = widget.GoalItem['Title'];
      description = widget.GoalItem['Description'];
      if(widget.GoalItem['Photo'] != null){
        goalImage = Container(
          child: CachedNetworkImage(
            imageUrl: widget.GoalItem['Photo'],
            maxHeightDiskCache: 300,
          ),
        );
      }
    });

    var allGoals;
    final docRef = db.collection("users_goals").doc("${widget.Userdata['username']}");
    docRef.get().then(
          (DocumentSnapshot doc) {
        setState(() {
          allGoals = doc.data() as Map<String, dynamic>;
          toBeEditGoal = allGoals[widget.GoalTitle];
        });
        print(toBeEditGoal[widget.index]);
      },
    );

  }


  void selectImage()async{
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      if(im != null){
        _image = im;
        goalImage = Container(
          child: Image(image : MemoryImage(_image!)),
        );
      }

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : false,
      backgroundColor: Colors.white,
      body: Stack(
          children : [
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
                Container(
                  height: MediaQuery.of(context).size.height - 100,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.centerRight,
                        end: Alignment.centerLeft,
                        colors: [HexColor("#FB9F40").withOpacity(0.6),HexColor("#ED1C24").withOpacity(0.6)]
                    ),
                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40)),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0,right: 20,bottom: 60),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height - 230,
                        decoration: BoxDecoration(
                          color: HexColor("#F8F8F8"),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    child: GradientIcon(
                                        Icons.cancel,
                                        35,
                                        LinearGradient(
                                            colors: [HexColor("#FB9F40"),HexColor("#ED1C24")]
                                        )
                                    ),
                                    onTap: (){
                                      Navigator.pop(context);
                                    },
                                  ),
                                  InkWell(
                                    onTap: (){
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(8)),
                                              title: const Text("Set Title"),
                                              content: TextFormField(
                                                onChanged: (String value) {
                                                  setState(() {
                                                    title = value;
                                                  });
                                                },
                                                initialValue: title,
                                              ),
                                            );
                                          }
                                      );
                                    },
                                    child: Container(
                                      height: 35,
                                      width: 155,
                                      decoration: BoxDecoration(
                                        border: GradientBoxBorder(
                                            gradient: LinearGradient(colors: [HexColor("#FB9F40"),HexColor("#ED1C24")])
                                        ),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Center(
                                        child: Text(
                                          title,
                                          style: const TextStyle(
                                              fontFamily: 'JosefinSans',
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.grey
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 10,
                                    width: 50,
                                    color: Colors.transparent,
                                  )
                                ],
                              ),
                              InkWell(
                                onTap: (){
                                  selectImage();
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width-24,
                                  height: MediaQuery.of(context).size.height/2.5,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      border: GradientBoxBorder(gradient: LinearGradient(colors: [HexColor("#FB9F40"),HexColor("#ED1C24")]))
                                  ),
                                  child: goalImage,
                                ),
                              ),
                              InkWell(
                                onTap: (){
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(8)),
                                          title: const Text("Set Description"),
                                          content: TextFormField(
                                            onChanged: (String value) {
                                              setState(() {
                                                description = value;
                                              });
                                            },
                                            initialValue: description,
                                          ),
                                        );
                                      }
                                  );
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width-24,
                                  height: MediaQuery.of(context).size.height/10,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      border: GradientBoxBorder(gradient: LinearGradient(colors: [HexColor("#FB9F40"),HexColor("#ED1C24")]))
                                  ),
                                  child: Center(
                                    child: Text(
                                      description,
                                      style: const TextStyle(
                                          fontFamily: 'JosefinSans',
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.grey
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: ()async{
                                  String filename = DateTime.now().toString();
                                  String url = await UploadImage().UploadImageHere(path: '${widget.Userdata['username']}',filename: filename, file: _image!);

                                  final storageRef = FirebaseStorage.instance.ref();
                                  final desertRef = storageRef.child("${widget.Userdata['username']}/${toBeEditGoal[widget.index]['Date']}");
                                  await desertRef.delete();

                                  Map<String, dynamic> temp = {'Title' : title,'Photo' : url,'Description' : description,'Date' : filename};

                                  toBeEditGoal[widget.index] = temp;

                                  db.collection('users_goals').doc(widget.Userdata['username']).set({
                                    widget.GoalTitle : toBeEditGoal,
                                  });
                                  Get.off(OverlayScreen(widget.Userdata,index: 5,));
                                  // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => OverlayScreen(widget.Userdata,index: 5,)));
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width-24,
                                  height: MediaQuery.of(context).size.height/15,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      border: GradientBoxBorder(gradient: LinearGradient(colors: [HexColor("#FB9F40"),HexColor("#ED1C24")]))
                                  ),
                                  child: const Center(
                                    child: Text(
                                      "Save",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 18,
                                        fontFamily: 'JosefinSans',
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
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
                              padding: const EdgeInsets.only(right: 10.0),
                              child: InkWell(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => MyPeopleScreen(widget.Userdata)));
                                  },
                                  child: const Icon(Icons.people_outline,size: 35)),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: InkWell(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsScreen(widget.Userdata)));
                                  },
                                  child: const Icon(Icons.settings,size: 35,)
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
}
