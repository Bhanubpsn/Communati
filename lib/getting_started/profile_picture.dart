import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:communati/Homepage/homepage.dart';
import 'package:communati/resources/auth_method.dart';
import 'package:communati/util/Pick_Image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:image_picker/image_picker.dart';
import '../util/gradient_text.dart';
import '../util/hexcolor.dart';
import 'dart:async';

class ProfilePicture extends StatefulWidget {
  late var phoneNum;
  late String fullname;
  late String _password;
  late String _username;
  ProfilePicture(this.phoneNum,this.fullname,this._password,this._username, {super.key});

  @override
  State<ProfilePicture> createState() => _ProfilePictureState();
}

class _ProfilePictureState extends State<ProfilePicture> {

  Uint8List? _image;

  void selectImage()async{
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      if(im != null){
        _image = im;
        _profilePic = CircleAvatar(
          radius: 114,
          backgroundImage: MemoryImage(_image!),
        );
      }
      
    });
  }

  Widget _profilePic = Container(
    height: 229,
    width: 229,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(116),
      border: GradientBoxBorder(
        gradient: LinearGradient(colors: [HexColor("#ED1C24"),HexColor("#FB9F40")]),
        width: 1.8,
      ),
    ),
    child: Center(
      child: Text(
        "Add Profile Picture",
        style: TextStyle(
            fontFamily: 'JosefinSans',
            fontWeight: FontWeight.w400,
            fontSize: 20,
            color: Colors.grey
        ),
      ),
    ),
  );

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
              'Verification',
              style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'JosefinSans'
              ),
              gradient: LinearGradient(colors: [
                HexColor("#ED1C24"),HexColor("#FB9F40")
              ]),
            ),
            InkWell(
              onTap: (){
                selectImage();
              },
              child: _profilePic,
            ),
            Text(
              "Help us keep communati safe by\nverifying your self with one selfie",
              style: TextStyle(
                fontFamily: 'JosefinSans',
                fontSize: 16,
                fontWeight: FontWeight.w400
              ),
            ),
            InkWell(
              child: Container(
                height: 50,
                width: 273,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [HexColor("#ED1C24"),HexColor("#FB9F40")]
                    ),
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Center(
                  child: Text(
                    "Verify",
                    style: TextStyle(
                        fontSize: 21.07,
                        color: Colors.white,
                        fontFamily: 'JosefinSans'
                    ),
                  ),
                ),
              ),
              onTap: (){
                var Userdata;
                AuthMethod().signUpUser(username: widget._username, password: widget._password, fullname: widget.fullname, phoneNum: widget.phoneNum,file: _image!);
                const snackBar = SnackBar(
                    content: Row(
                      children: [
                        Text("Please Wait few seconds.....   "),
                        CircularProgressIndicator(),
                      ],
                    ),
                    duration: Duration(seconds: 20),
                    backgroundColor: Colors.green
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                Timer(
                    const Duration(seconds: 20),
                    () {
                      Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) => Homepage(Userdata)));
                    }
                );
                Timer(
                  const Duration(seconds: 18),
                    (){
                        var db = FirebaseFirestore.instance;
                        User? firebaseUser = FirebaseAuth.instance.currentUser;

                        final docRef = db.collection("users").doc("${firebaseUser?.phoneNumber}");
                        docRef.get().then(
                            (DocumentSnapshot doc) {
                                setState(() {
                                  Userdata = doc.data() as Map<String, dynamic>;
                                });
                                print(Userdata);
                            },
                            onError: (e) => print("Error getting document: $e"),
                        );
                    }
                );

              },
            ),
            Container(
              height: 50,
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
                      'Retake',
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
          ],
        ),
      ),
    );
  }
}
