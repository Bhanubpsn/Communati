import 'package:communati/getting_started/Get_Started.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditAccount extends StatefulWidget {
  const EditAccount({super.key});

  @override
  State<EditAccount> createState() => _EditAccountState();
}

class _EditAccountState extends State<EditAccount> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  signOut() async {
    await auth.signOut();
    Get.offAll(() => GetStarted());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : false,
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0,right: 16,top: 40),
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
                  child: Text(
                    "close",
                    style: TextStyle(
                      fontFamily: 'Dongle',
                      fontSize: 28,
                      fontWeight: FontWeight.w400
                    ),
                  ),
                ),
                Text(
                  "account",
                  style: TextStyle(
                      fontFamily: 'Dongle',
                      fontSize: 35,
                      fontWeight: FontWeight.w400
                  ),
                ),
                const SizedBox(width: 20,)
              ],
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 53*4,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                      width: 1,
                      color: Colors.grey
                  )
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0,bottom: 8,left: 16,right: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "full name",
                          style: TextStyle(
                              fontSize: 25,
                              fontFamily: 'Dongle',
                              fontWeight: FontWeight.w400
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(height: 0,thickness: 1.5,),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0,bottom: 8,left: 16,right: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "username",
                          style: TextStyle(
                              fontSize: 25,
                              fontFamily: 'Dongle',
                              fontWeight: FontWeight.w400
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(height: 0,thickness: 1.5,),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0,bottom: 8,left: 16,right: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "phone number",
                          style: TextStyle(
                              fontSize: 25,
                              fontFamily: 'Dongle',
                              fontWeight: FontWeight.w400
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(height: 0,thickness: 1.5,),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0,bottom: 8,left: 16,right: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "email",
                          style: TextStyle(
                              fontSize: 25,
                              fontFamily: 'Dongle',
                              fontWeight: FontWeight.w400
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 53,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                      width: 1,
                      color: Colors.grey
                  )
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0,bottom: 8,left: 16,),
                child: InkWell(
                  onTap: (){
                    signOut();
                  },
                  child: Center(
                    child: Text(
                      "Logout",
                      style: TextStyle(
                          fontFamily: 'Dongle',
                          fontWeight: FontWeight.w400,
                          fontSize: 28
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 300,)
          ],
        ),
      ),
    );
  }
}
