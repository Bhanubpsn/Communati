import 'package:communati/Homepage/My_People/my_people_screen.dart';
import 'package:communati/Homepage/Settings/settings_screen.dart';
import 'package:communati/Homepage/homepage.dart';
import 'package:communati/Homepage/overlay_menu/overlay_options/my_goal/my_goal.dart';
import 'package:communati/Homepage/overlay_menu/overlay_options/my_life_events/my_life_events.dart';
import 'package:communati/Homepage/overlay_menu/overlay_options/my_memories/my_memories.dart';
import 'package:communati/Homepage/overlay_menu/overlay_options/my_photos/my_photos.dart';
import 'package:communati/Homepage/overlay_menu/overlay_options/my_space/my_space.dart';
import 'package:communati/util/gradient_icon.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import '../../util/hexcolor.dart';
import 'package:get/get.dart';

class OverlayScreen extends StatefulWidget {
  Map<String ,dynamic> Userdata;
  OverlayScreen(this.Userdata,{Key? key, required this.index}) : super(key: key);
  int index;

  @override
  State<OverlayScreen> createState() => _OverlayScreenState();
}

class _OverlayScreenState extends State<OverlayScreen> {
  User? firebaseUser = FirebaseAuth.instance.currentUser;
  List<String> OverlayButtons =  ['My Space','My Life Events','My Memories','My Photos','My Goals'];

  final storageRef = FirebaseStorage.instance.ref();
  List photoURLs = [];
  List temp = [];

  void listingImages()async{
    final storageRefFiles = FirebaseStorage.instance.ref().child(widget.Userdata['username']);
    final listResult = await storageRefFiles.listAll();
    for (var item in listResult.items) {
      final imageUrl = await storageRef.child(item.fullPath.toString()).getDownloadURL();
      temp.add(imageUrl);
      print(imageUrl);
    }
    setState(() {
      photoURLs = temp;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listingImages();
  }

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
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    separatorBuilder: (context, index) =>const SizedBox(width: 4,),
                    itemCount: OverlayButtons.length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.only(left: 8.0,right: 8),
                      child: InkWell(
                        child: Container(
                          width: MediaQuery.of(context).size.width / 3.3,
                          height: 41,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: ColorSelector(index),
                              ),
                              borderRadius: BorderRadius.circular(4),
                              border: GradientBoxBorder(gradient: LinearGradient(colors: [HexColor("#FB9F40"),HexColor("#ED1C24")]),width: 1.25)
                          ),
                          child: Center(
                              child: Text(
                                OverlayButtons[index],
                                style: TextStyle(
                                  fontFamily: 'JosefinSans',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: (index+1 == widget.index) ? Colors.white : Colors.black,
                                ),
                              )
                          ),
                        ),
                        onTap: (){
                          setState(() {
                            widget.index = index+1;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                OverlayOptionSelector(widget.index),
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
                            child: InkWell(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => MyPeopleScreen(widget.Userdata)));
                                },
                                child: Icon(Icons.people_outline,size: 35)
                            ),
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

  Widget OverlayOptionSelector(int index){
    if(index == 1){
      return MySpace(widget.Userdata);
    }
    else if(index == 2){
      return MyLifeEvents(widget.Userdata);
    }
    else if(index == 3){
      return MyMemories(widget.Userdata);
    }
    else if(index == 4){
      return MyPhotos(photoURLs);
    }
    else if(index ==  5){
      return MyGoal(widget.Userdata);
    }
    return MySpace(widget.Userdata);
  }

  List<Color> ColorSelector(int index){
    if(index+1 == widget.index){
      List<Color> Selected = [HexColor("#FB9F40"),HexColor("#ED1C24")];
      return Selected;
    }
    return [Colors.transparent,Colors.transparent];
  }

}
