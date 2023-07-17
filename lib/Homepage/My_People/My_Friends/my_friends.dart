import 'package:communati/Homepage/My_People/My_Friends/my_friends_info.dart';
import 'package:flutter/material.dart';
import '../../../util/hexcolor.dart';

class MyFriends extends StatefulWidget {
  Map<String ,dynamic> Userdata;
  MyFriends(this.Userdata,{super.key});

  @override
  State<MyFriends> createState() => _MyFriendsState();
}

class _MyFriendsState extends State<MyFriends> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 3*MediaQuery.of(context).size.height/5,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40)),
                gradient: LinearGradient(
                    begin: Alignment.centerRight,
                    end: Alignment.centerLeft,
                    colors: [HexColor("#FB9F40").withOpacity(0.6),HexColor("#ED1C24").withOpacity(0.6)]
                )
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 10,),
                SizedBox(
                  height: MediaQuery.of(context).size.height/2 ,
                  child: ListView.builder(
                      itemCount: 5,
                      itemBuilder: (BuildContext context,int index){
                        return MyFriendsCard(index,context);
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

  Widget MyFriendsCard(int index,BuildContext context){
    return Container(
      margin: const EdgeInsets.only(left: 16,right: 16,bottom: 10,top: 10),
      width: MediaQuery.of(context).size.width,
      height: 158,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: HexColor("#F8F8F8"),
        boxShadow: const [
          BoxShadow(
              color: Colors.grey, //New
              blurRadius: 2.0,
              offset: Offset(0, 3))
        ],
      ),
      child: Stack(
          children : [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => MyFriendsInfo(widget.Userdata)));
                      },
                      child: Container(
                        height: 72,
                        width: 72,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage("images/micheal_scott.jpg")
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 50.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "Micheal Scott",
                          style: TextStyle(
                            fontFamily: 'JosefinSans',
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                          ),
                        ),
                        Row(
                          children: [
                            Icon(Icons.pin_drop_outlined,size: 15,),
                            Text(
                              "  U.S.A",
                              style: TextStyle(
                                fontFamily: 'JosefinSans',
                                fontWeight: FontWeight.w400,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.cake_outlined,size: 15,),
                            Text(
                              "  40 year",
                              style: TextStyle(
                                fontFamily: 'JosefinSans',
                                fontWeight: FontWeight.w400,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.cases_outlined,size: 15,),
                            Text(
                              "  Branch Manager",
                              style: TextStyle(
                                fontFamily: 'JosefinSans',
                                fontWeight: FontWeight.w400,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            Positioned(
              top: 0,
              left: 280,
              child: PopupMenuButton<int>(
                icon: Icon(Icons.more_vert,color: Colors.grey,),
                iconSize: 25,
                itemBuilder: (context) => [
                  const PopupMenuItem(
                      value: 1,
                      child: Center(
                        child: Text(
                          "Remove",
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
            Positioned(
                top: 12,
                left: 10,
                child: Text(
                  "@MGScott",
                  style: TextStyle(
                    fontFamily: 'JosefinSans',
                    fontSize: 15,
                    fontWeight: FontWeight.w500
                  ),
                )
            ),
            const Divider(height: 80,thickness: 1,),
          ]

      ),
    );

  }
}
