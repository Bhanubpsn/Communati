import 'package:communati/Homepage/overlay_menu/overlay_options/my_space/add_space.dart';
import 'package:flutter/material.dart';
import '../../../../util/hexcolor.dart';

class MySpace extends StatefulWidget {
  Map<String ,dynamic> Userdata;
  MySpace(this.Userdata,{super.key});

  @override
  State<MySpace> createState() => _MySpaceState();
}

class _MySpaceState extends State<MySpace> {
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
                        itemCount: 10,
                        itemBuilder: (BuildContext context,int index){
                          return MySpaceCard(index,context);
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
                child: Center(
                  child: Icon(Icons.add,size: 30,color: Colors.white,),
                ),
              ),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => AddSpace(widget.Userdata)));
              },
            ),
          )
        ]

      ),
    );
  }
  Widget MySpaceCard(int index, BuildContext context){
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
