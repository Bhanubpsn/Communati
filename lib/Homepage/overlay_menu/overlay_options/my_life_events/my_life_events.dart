import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:communati/Homepage/overlay_menu/overlay_options/my_life_events/add_events.dart';
import 'package:communati/Homepage/overlay_menu/overlay_options/my_life_events/edit_event.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import '../../../../util/hexcolor.dart';

class MyLifeEvents extends StatefulWidget {
  Map<String ,dynamic> Userdata;
  MyLifeEvents(this.Userdata,{super.key});

  @override
  State<MyLifeEvents> createState() => _MyLifeEventsState();
}

class _MyLifeEventsState extends State<MyLifeEvents> {

  List lifeEvents = [];
  var db = FirebaseFirestore.instance;

  void _loadEvents(){
    var temp;
    final docRef = db.collection("users_life_events").doc(widget.Userdata['username']);
    docRef.get().then(
          (DocumentSnapshot doc) {
        setState(() {
          temp = doc.data() as Map<String, dynamic>;
          lifeEvents = temp['events'];
        });
        print(lifeEvents.length);
      },
    );
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadEvents();
  }



  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
          children : [
            Padding(
              padding: const EdgeInsets.only(bottom: 35.0),
              child: Container(
                  height: MediaQuery.of(context).size.height-250,
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
                          itemCount: lifeEvents.length,
                          itemBuilder: (BuildContext context,int index){
                            return MyLifeEventsCard(index,context);
                          }
                      ),
                    ),
                  )
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height - 320,
              left: MediaQuery.of(context).size.width - 70,
              child: InkWell(
                child: Container(
                  height: 53,
                  width: 53,
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
                    child: Icon(Icons.add,size: 30,color: Colors.white,),
                  ),
                ),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AddEvents(widget.Userdata,lifeEvents)));
                },
              ),
            )
          ]

      ),
    );
  }




  Widget MyLifeEventsCard(int index, BuildContext context){
    return Container(
      margin: const EdgeInsets.only(left: 16,right: 16,bottom: 10,top: 10),
      width: MediaQuery.of(context).size.width,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children : [
              const SizedBox(width: 30,),
              Text(
                lifeEvents[index]['Title'],
                style: const TextStyle(
                  fontFamily: 'JosefinSans',
                  fontSize: 17,
                  fontWeight: FontWeight.w700
                ),
              ),
              PopupMenuButton<int>(
                icon: const Icon(Icons.more_horiz,color: Colors.grey,),
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
                  if(value ==  1){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>
                      EditEvent(index,lifeEvents,widget.Userdata)
                    ));
                  }

                  if(value == 2){

                    final storageRef = FirebaseStorage.instance.ref();
                    final desertRef = storageRef.child("${widget.Userdata['username']}/${lifeEvents[index]['Date'].toString().replaceAll('/', '-')}");
                    await desertRef.delete();
                    var temp = lifeEvents;
                    temp.removeAt(index);
                    setState(() {
                      lifeEvents = temp;
                    });
                    var db = FirebaseFirestore.instance;
                    db.collection("users_life_events").doc('${widget.Userdata['username']}').update({
                      'events' : lifeEvents,
                    });


                  }
                },
              ),
            ]

          ),
          const Divider(thickness: 1,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  lifeEvents[index]['Subtitle'],
                  style: const TextStyle(
                    fontFamily: 'JosefinSans',
                    fontSize: 14,
                    fontWeight: FontWeight.w500
                  ),
                ),
                Text(
                  lifeEvents[index]['Date'],
                  style: const TextStyle(
                    fontFamily: 'JosefinSans',
                    fontSize: 14,
                      fontWeight: FontWeight.w500
                  ),
                )
              ],
            ),
          ),
          if(lifeEvents[index]['Photo'] != null && lifeEvents[index]['Photo'] != "")
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CachedNetworkImage(
                  imageUrl: lifeEvents[index]['Photo'],
                  maxHeightDiskCache: 300,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    CircularProgressIndicator(value: downloadProgress.progress),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                lifeEvents[index]['Description'],
                style: const TextStyle(
                  fontFamily: 'JosefinSans',
                  fontSize: 14,
                  fontWeight: FontWeight.w500
                ),
              ),
            ),
          )

        ],
      ),
    );
  }
}
