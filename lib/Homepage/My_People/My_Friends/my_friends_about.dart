import 'package:flutter/material.dart';
import '../../../util/hexcolor.dart';

class MyFriendsAbout extends StatelessWidget {
  const MyFriendsAbout({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 30.0,right: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Bio",
                style: TextStyle(
                    fontFamily: 'JosefinSans',
                    fontSize: 20,
                    fontWeight: FontWeight.w400
                ),
              ),
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
                "Not him old music think his found enjoy merry. Listening acuteness dependent at or an. Apartments thorouh",
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
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Basics",
                style: TextStyle(
                    fontFamily: 'JosefinSans',
                    fontSize: 20,
                    fontWeight: FontWeight.w400
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10,),
        Padding(
          padding: const EdgeInsets.only(left: 30.0,right: 30,bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.work_outline_sharp,size: 15,),
                  const SizedBox(width: 8,),
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
                "Branch Manager",
                style: TextStyle(
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.menu_book_sharp,size: 15,),
                  const SizedBox(width: 8,),
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
                "Dunder Mifflin",
                style: TextStyle(
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.abc_sharp,size: 20,),
                  const SizedBox(width: 8,),
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
                "English",
                style: TextStyle(
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
    );
  }
}
