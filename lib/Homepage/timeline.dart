import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../util/hexcolor.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Timeline extends StatefulWidget {
  Map<String, dynamic> Userdata;
  Timeline(this.Userdata,{super.key});

  @override
  State<Timeline> createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  Widget profilepic = Container(
    height: 144,
    width: 144,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(100),
      image: const DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage("images/default_account.jpg")
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Container(
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
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
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                    ),
                  ):
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
                  )
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 25.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        (widget.Userdata != null) ?  widget.Userdata['Display Details']['Name'] : "",
                        style: const TextStyle(
                            fontFamily: 'Dongle',
                            fontSize: 32,
                            fontWeight: FontWeight.w400
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Icon(Icons.cake_outlined,size: 20,),
                          Container(
                            width: 60,
                            child: FittedBox(
                              fit: BoxFit.fitWidth,
                              child: Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(top: 8.0,left: 2,right: 10),
                                    child: Text(
                                      (widget.Userdata != null) ?  "${widget.Userdata['Display Details']['Age'].toString()} year old" : "   year old",
                                      style: TextStyle(
                                          fontFamily: 'Dongle',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 22
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Icon(Icons.pin_drop_outlined,size: 20,),
                          Container(
                            width: 50,
                            height: 50,
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top :8.0),
                                    child: Text(
                                      (widget.Userdata != null) ?  widget.Userdata['Display Details']['Location'] : "",
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
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 3*MediaQuery.of(context).size.height/5,
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
                    width: 199,
                    height: 52,
                    decoration: BoxDecoration(
                      color: HexColor("#FFF5F5"),
                      borderRadius: BorderRadius.circular(26)
                    ),
                    child: const Center(
                      child: Text(
                        "Timeline",
                        style: TextStyle(
                          fontFamily: 'Dongle',
                          fontSize: 33,
                          fontWeight: FontWeight.w400
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height/2.35,
                  child: ListView.builder(
                      itemCount: 10,
                      itemBuilder: (BuildContext context,int index){
                        return TimelineCards(index,context);
                      }
                  ),
                )


              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget TimelineCards(int index,BuildContext context){
    return Container(
      margin: const EdgeInsets.only(left: 16,right: 16,bottom: 10,top: 10),
      width: MediaQuery.of(context).size.width,
      height: 220,
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
      child: Stack(
        children : [
          Center(
            child: Text(
              index.toString(),
            ),
          ),
          Positioned(
              top: 0,
              left: 280,
              child: PopupMenuButton<int>(
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
                onSelected: (value) {},
              ),
          ),
          const Divider(height: 80,thickness: 1,),
        ]

      ),
    );

  }
}
