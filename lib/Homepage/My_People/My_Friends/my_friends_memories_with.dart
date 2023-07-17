import 'package:flutter/material.dart';
import '../../../util/hexcolor.dart';

class MyFriendsMemoriesWith extends StatelessWidget {
  const MyFriendsMemoriesWith({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height/2.5,
          child: ListView.builder(
              itemCount: 10,
              itemBuilder: (BuildContext context,int index){
                return MyLifeEventsCard(index,context);
              }
          ),
        ),
      ],
    );
  }

  Widget MyLifeEventsCard(int index, BuildContext context){
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
                icon: Icon(Icons.more_horiz,color: Colors.grey,),
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
