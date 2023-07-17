import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:communati/Homepage/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../util/hexcolor.dart';

class ProfileView extends StatefulWidget {
  Map<String, dynamic> Userdata;
  ProfileView(this.Userdata,{super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  var Bio,Work,Education,Language,Location,Age;

  var db = FirebaseFirestore.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      Bio = widget.Userdata['Basics']['Bio'];
      Work = widget.Userdata['Display Details']['Work'];
      Education = widget.Userdata['Basics']['Education'];
      Language = widget.Userdata['Basics']['Language'];
      Location = widget.Userdata['Display Details']['Location'];
      Age = widget.Userdata['Display Details']['Age'].toString();
    });

  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 144,
          width: 144,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
          ),
          child:
          (widget.Userdata != null) ?
          Container(
            height: 144,
            width: 144,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
            ),
            child: CachedNetworkImage(
              imageUrl: widget.Userdata["photoUrl"],
              maxHeightDiskCache: 300,
              imageBuilder: (context, imageProvider) =>
                  Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          )
                      )
                  ),
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  CircularProgressIndicator(value: downloadProgress.progress),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ) :
          Container(
            height: 144,
            width: 144,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              image: const DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage("images/default_account.jpg")
              ),
            ),
          ),
        ),
        Text(
          (widget.Userdata != null) ?  widget.Userdata['Display Details']['Name'] : "",
          style: const TextStyle(
            fontFamily: 'Dongle',
            fontWeight: FontWeight.w400,
            fontSize: 32
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
                child: Icon(Icons.cake_outlined,size: 20,),
                onTap: (){
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          title: Text("Set Age"),
                          content: TextField(
                            keyboardType: TextInputType.number,
                            onChanged: (String value) {
                              setState(() {
                                Age = value;
                              });
                            },

                          ),
                          actions: [
                            ElevatedButton(
                              onPressed: () {
                                db.collection('users').doc(widget.Userdata['phoneNumber']).update({
                                  'Display Details.Age' : int.parse(Age),
                                });
                                Navigator.of(context).pop();
                              },
                              child: Text("Set"),
                            ),
                            ElevatedButton(
                              onPressed:(){
                                Navigator.pop(context);
                              },
                              child: const Text(
                                "Cancel",
                                style: TextStyle(
                                    color: Colors.grey
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white
                              ),
                            )
                          ],

                        );
                      }
                  );
                },
            ),
            Container(
              width: 100,
              child: Center(
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0,left: 2,right: 10),
                      child: Text(
                        "${Age} years old",
                        style: const TextStyle(
                            fontFamily: 'Dongle',
                            fontWeight: FontWeight.w400,
                            fontSize: 20
                        ),
                      ),
                    ),
                  ],
                ),
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
                          title: Text("Set Location"),
                          content: TextFormField(
                            onChanged: (String value) {
                              setState(() {
                                Location = value;
                              });
                            },
                            initialValue: Location,
                          ),
                          actions: [
                            ElevatedButton(
                              onPressed: () {
                                db.collection('users').doc(widget.Userdata['phoneNumber']).update({
                                  'Display Details.Location' : Location,
                                });
                                Navigator.of(context).pop();
                              },
                              child: Text("Set"),
                            ),
                            ElevatedButton(
                              onPressed:(){
                                Navigator.pop(context);
                              },
                              child: const Text(
                                "Cancel",
                                style: TextStyle(
                                    color: Colors.grey
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white
                              ),
                            )
                          ],

                        );
                      }
                  );
                },
                child: Icon(Icons.pin_drop_outlined,size: 20,)
            ),
            Container(
              width: 100,
              child: Center(
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top :8.0),
                      child: Text(
                        Location,
                        style: const TextStyle(
                            fontFamily: 'Dongle',
                            fontSize: 18,
                            fontWeight: FontWeight.w400
                        ),
                      ),
                    )
                  ],
                ),
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
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40)),
                gradient: LinearGradient(
                    begin: Alignment.centerRight,
                    end: Alignment.centerLeft,
                    colors: [HexColor("#FB9F40").withOpacity(0.6),HexColor("#ED1C24").withOpacity(0.6)]
                )
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20.0,bottom: 10),
                  child: Container(
                    width: 146,
                    height: 44,
                    decoration: BoxDecoration(
                        color: HexColor("#FFF5F5"),
                        borderRadius: BorderRadius.circular(26),
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.grey, //New
                              blurRadius: 5.0,
                              offset: Offset(6, 2))
                        ],
                    ),
                    child: Center(
                      child: Text(
                        (widget.Userdata != null) ?  "About ${widget.Userdata['Display Details']['Name']}" : "",
                        style: const TextStyle(
                            fontFamily: 'JosefinSans',
                            fontSize: 12,
                            fontWeight: FontWeight.w400
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30.0,right: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Bio",
                        style: TextStyle(
                          fontFamily: 'JosefinSans',
                          fontSize: 20,
                          fontWeight: FontWeight.w400
                        ),
                      ),
                      InkWell(
                        child: Icon(Icons.edit,size :17),
                        onTap: (){
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                  title: Text("Update Bio"),
                                  content: TextFormField(
                                    initialValue: Bio,
                                    onChanged: (String value) {
                                      setState(() {
                                        Bio = value;
                                      });
                                    },

                                  ),
                                  actions: [
                                    ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          db.collection('users').doc(widget.Userdata['phoneNumber']).update({
                                            'Basics.Bio' : Bio,
                                          });
                                        });
                                        Navigator.of(context).pop();
                                      },
                                      child: Text("Update"),
                                    ),
                                    ElevatedButton(
                                      onPressed:(){
                                        Navigator.pop(context);
                                      },
                                      child: const Text(
                                        "Cancel",
                                        style: TextStyle(
                                            color: Colors.grey
                                        ),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.white
                                      ),
                                    )
                                  ],

                                );
                              }
                          );
                        },
                      )
                    ],
                  ),
                ),
                Container(
                  height: 92,
                  width: MediaQuery.of(context).size.width-32,
                  decoration: BoxDecoration(
                    color: HexColor("#F8F8F8"),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      Bio,
                      style: TextStyle(
                        fontFamily: 'JosefinSans',
                        fontSize: 13,
                        color: HexColor("#7D7D7D"),
                      ),
                    ),
                  )
                ),
                Padding(
                  padding: const EdgeInsets.only(top : 10,left: 30.0,right: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "My Basics",
                        style: TextStyle(
                            fontFamily: 'JosefinSans',
                            fontSize: 20,
                            fontWeight: FontWeight.w400
                        ),
                      ),
                      InkWell(
                          child: Icon(Icons.edit,size :17),
                          onTap: (){
                            _showDialog(context,Work,Education,Language);
                          },
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.only(left: 30.0,right: 30,bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(Icons.work_outline_sharp,size: 15,),
                          SizedBox(width: 8,),
                          Text(
                            "Work",
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 12,
                              fontWeight: FontWeight.w400
                            ),
                          )
                        ],
                      ),
                      Text(
                        Work,
                        style: const TextStyle(
                          fontFamily: 'JosefinSans',
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: Colors.white
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30.0,right: 30,bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(Icons.menu_book_sharp,size: 15,),
                          SizedBox(width: 8,),
                          Text(
                            "Education",
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 12,
                              fontWeight: FontWeight.w400
                            ),
                          )
                        ],
                      ),
                      Text(
                        Education,
                        style: const TextStyle(
                          fontFamily: 'JosefinSans',
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: Colors.white
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30.0,right: 30,bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(Icons.abc_sharp,size: 20,),
                          SizedBox(width: 8,),
                          Text(
                            "Language",
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 12,
                              fontWeight: FontWeight.w400
                            ),
                          )
                        ],
                      ),
                      Text(
                        Language,
                        style: const TextStyle(
                          fontFamily: 'JosefinSans',
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: Colors.white
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  _showDialog(BuildContext context,String _work,String _education,String _language) async{
    await showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            contentPadding:const EdgeInsets.all(10),
            content: Column(
              children: [
                const Text("Update Your Basics"),
                Expanded(
                    child: TextFormField(
                      autofocus: true,
                      decoration:const InputDecoration(
                          labelText: "Your Work*"
                      ),
                      initialValue: _work,
                      onChanged: (value){
                        setState(() {
                          _work = value;
                        });
                      },
                    )
                ),
                Expanded(
                    child: TextFormField(
                      autofocus: true,
                      autocorrect: true,
                      decoration:const InputDecoration(
                          labelText: "Your Education*"
                      ),
                      initialValue: _education,
                      onChanged: (value){
                        setState(() {
                          _education = value;
                        });
                      },
                    )
                ),
                Expanded(
                    child: TextFormField(
                      autofocus: true,
                      autocorrect: true,
                      decoration:const InputDecoration(
                          labelText: "Your Languages*"
                      ),
                      initialValue: _language,
                      onChanged: (value){
                        setState(() {
                          _language = value;
                        });
                      },
                    )
                ),
              ],
            ),
            actions: [
              ElevatedButton(
                  onPressed: (){
                    db.collection('users').doc(widget.Userdata['phoneNumber']).update({
                        'Basics.Education' : _education,
                        'Basics.Language' : _language,
                        'Display Details.Work' : _work,
                    });

                    setState(() {
                      Work = _work;
                      Education = _education;
                      Language = _language;
                    });
                    Navigator.pop(context);
                  },
                  child:const Text("Update")
              ),
              ElevatedButton(
                  onPressed:(){
                    Navigator.pop(context);
                  },
                  child: const Text(
                      "Cancel",
                      style: TextStyle(
                        color: Colors.grey
                      ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white
                  ),
              )
            ],
          );
        }
    );

  }


}
