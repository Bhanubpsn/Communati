import 'package:flutter/material.dart';
import 'package:gradient_borders/gradient_borders.dart';
import '../../../util/hexcolor.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(top:60.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.arrow_back_ios_new_outlined,color: Colors.grey,)),
                Container(
                  height: 32,
                  width: MediaQuery.of(context).size.width/1.2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    border: GradientBoxBorder(gradient: LinearGradient(colors: [HexColor("#FB9F40"),HexColor("#ED1C24")]))
                  ),
                  child: Center(
                    child: Text(
                      "Search",
                      style: TextStyle(
                        color: Colors.grey
                      ),
                    ),
                  ),
                )
              ],
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height/1.3,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.topLeft,
                      colors: [HexColor("#FB9F40").withOpacity(0.6),HexColor("#ED1C24").withOpacity(0.6)]
                  ),
                borderRadius: BorderRadius.only(topRight: Radius.circular(40),topLeft: Radius.circular(40))
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (BuildContext context,int index){
                      return MyFriendsChatCard(index,context);
                    }
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget MyFriendsChatCard(int index, BuildContext context){
    return Container(
      margin: const EdgeInsets.only(left: 16,right: 16,bottom: 10,top: 10),
      width: MediaQuery.of(context).size.width,
      height: 73,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage("images/download.jpg")
                      ),
                    ),
                  ),
                ),
                Text(
                  "Zendaya",
                  style: TextStyle(
                    fontFamily: 'JosefinSans',
                    fontSize: 15,

                  ),
                )
              ],
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
          ]

      ),
    );
  }
}
