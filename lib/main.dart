import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:communati/Homepage/homepage.dart';
import 'package:communati/getting_started/Get_Started.dart';
import 'package:communati/util/hexcolor.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const SplashScreen());
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

Widget NextScreen = const GetStarted();

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    late Map<String, dynamic> Userdata;
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

    Timer(
        const Duration(seconds: 3), (){
                if (firebaseUser != null) {
                  setState(() {
                    NextScreen = Homepage(Userdata);
                  });
                }
                else {
                  setState(() {
                    NextScreen = const GetStarted();
                  });

                }
            }
    );
    Timer(
      const Duration(seconds: 6),(){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => NextScreen));
      }
    );
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [HexColor("#ED1C24"),HexColor("#FB9F40")]
          )
        ),
        child: Image.asset('images/flash.png'),
      ),
    );
  }
}

// class CheckLogIn extends StatelessWidget{
//   @override
//   Widget build(BuildContext context){
//     return FutureBuilder<FirebaseUser>(
//         future: FirebaseAuth.instance.currentUser(),
//         builder: (BuildContext context, AsyncSnapshot<FirebaseUser> snapshot){
//           if (snapshot.hasData){
//             FirebaseUser user = snapshot.data; // this is your user instance
//             /// is because there is user already logged
//             return MainScreen();
//           }
//           /// other way there is no user logged.
//           return LoginScreen();
//         }
//     );
//   }
// }
