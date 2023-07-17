import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:communati/getting_started/profile_picture.dart';
import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import '../util/gradient_text.dart';
import '../util/hexcolor.dart';
import 'login.dart';

class CreateAccount extends StatefulWidget {
  late var phoneNum;
  late String fullname;
  CreateAccount(this.phoneNum, this.fullname, {super.key});

  static String _username = "";
  static String _password = "";


  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : false,//
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GradientText(
              'Create Account',
              style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'JosefinSans'
              ),
              gradient: LinearGradient(colors: [
                HexColor("#ED1C24"),HexColor("#FB9F40")
              ]),
            ),
            Column(
              children: [
                Container(
                  height: 50,
                  width: 273,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: GradientBoxBorder(
                        gradient: LinearGradient(colors: [HexColor("#ED1C24"),HexColor("#FB9F40")]),
                        width: 1
                    ),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: TextField(
                      onChanged: (value){
                        setState(() {
                          CreateAccount._username = value;
                        });
                      },
                      cursorColor: Colors.red,
                      decoration: InputDecoration(
                        hintText: 'Username',
                        hintStyle: TextStyle(
                            fontFamily: 'JosefinSans',
                            color: Colors.red,
                            fontSize: 14,
                            fontWeight: FontWeight.w300
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                        ),

                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30,),
                Container(
                  height: 50,
                  width: 273,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: GradientBoxBorder(
                        gradient: LinearGradient(colors: [HexColor("#ED1C24"),HexColor("#FB9F40")]),
                        width: 1
                    ),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: TextField(
                      onChanged: (value){
                        setState(() {
                          CreateAccount._password = value;
                        });
                      },
                      cursorColor: Colors.red,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        hintStyle: TextStyle(
                            fontFamily: 'JosefinSans',
                            color: Colors.red,
                            fontSize: 14,
                            fontWeight: FontWeight.w300
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                        ),

                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Center(
              child: Text(
                "By continuing you agree to app terms &\n         services and privacy policy",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'JosefinSans'
                ),
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
                child: const Center(
                  child: Text(
                    "Create",
                    style: TextStyle(
                        fontSize: 21.07,
                        color: Colors.white,
                        fontFamily: 'JosefinSans'
                    ),
                  ),
                ),
              ),
              onTap: () async {
                bool check = await checkUsername(CreateAccount._username);
                if(check && CreateAccount._password.isNotEmpty && CreateAccount._username.isNotEmpty && CreateAccount._password.length >=8){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ProfilePicture(widget.phoneNum,widget.fullname,CreateAccount._password,CreateAccount._username)));
                }
                else if(CreateAccount._password.length < 8){
                  const snackBar = SnackBar(
                      content: Text("Password length should be > 8"),
                      duration: Duration(seconds: 1),
                      backgroundColor: Colors.red
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
                else{
                  const snackBar = SnackBar(
                      content: Text("These fields can't be empty"),
                      duration: Duration(seconds: 1),
                      backgroundColor: Colors.red
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              },
            ),
            Text(
              "Already have an account",
              style: TextStyle(
                  fontFamily: 'JosefinSans',
                  fontWeight: FontWeight.w400,
                  fontSize: 16
              ),
            ),
            InkWell(
              child: GradientText(
                'Log In',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'JosefinSans',
                  decoration: TextDecoration.underline,
                ),
                gradient: LinearGradient(colors: [
                  HexColor("#ED1C24"),HexColor("#FB9F40")
                ]),
              ),
              onTap: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LogIn()));
              },
            ),
          ],

        ),
      ),
    );
  }




  Future<bool> checkUsername(String Username) async {
    bool ans = true;
    var collection = FirebaseFirestore.instance.collection('login_authentication');
    var querySnapshots = await collection.get();
    for (var snapshot in querySnapshots.docs) {
      var documentID = snapshot.id;
      if(documentID == Username){
        setState(() {
          ans = false;
        });
        const snackBar = SnackBar(
            content: Text("Try a different Username"),
            duration: Duration(seconds: 1),
            backgroundColor: Colors.red
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        break;
      }
    }
    return ans;
  }


}
