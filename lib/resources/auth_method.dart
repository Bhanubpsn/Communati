import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:communati/resources/storage_methods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class AuthMethod{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? firebaseUser = FirebaseAuth.instance.currentUser;

  Future<String> signUpUser({required String username, required String password, required String fullname, required var phoneNum, required Uint8List file}) async
  {
    String res = "Some error occurred";

    try{
      if(username.isNotEmpty || password.isNotEmpty || fullname.isNotEmpty || phoneNum.isDefinedAndNotNull){
        
        String photoUrl = await StorageMethods().uploadImageToStorage('${username}/DP','Profile_pic', file);
        
        _firestore.collection('users').doc("${firebaseUser?.phoneNumber}").set({
          'username' : username,
          'password' : password,
          'fullname' : fullname,
          'phoneNumber' : firebaseUser?.phoneNumber.toString(),
          'photoUrl' : photoUrl,
          'Display Details' : {
            'Age' : 18,
            'Location' : ' ',
            'Name' : fullname,
            'Work' : ' '
          },
          'Basics' : {
            'Bio' : ' ',
            'Education' : ' ',
            'Language' : ' ',
          }
        });

        _firestore.collection('login_authentication').doc(username).set({
          'password' : password,
          'phoneNumber' : firebaseUser?.phoneNumber.toString(),
        });

        _firestore.collection('users_goals').doc(username).set({
          'goals' : [],
        });

        _firestore.collection('users_life_events').doc(username).set({
          'events' : [],
        });
        res = "Success";

      }
    }catch(err){
      res = err.toString();
    }

    return res;
  }
}