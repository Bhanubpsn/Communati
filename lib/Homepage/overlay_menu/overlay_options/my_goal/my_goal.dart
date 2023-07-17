import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:communati/Homepage/overlay_menu/overlay_options/my_goal/add_goal.dart';
import 'package:communati/Homepage/overlay_menu/overlay_options/my_goal/update_goal_screen.dart';
import 'package:communati/Homepage/overlay_menu/overlay_options/my_memories/add_memories.dart';
import 'package:communati/util/gradient_icon.dart';
import 'package:flutter/material.dart';
import '../../../../../util/hexcolor.dart';

class MyGoal extends StatefulWidget {
  Map<String ,dynamic> Userdata;
  MyGoal(this.Userdata,{super.key});

  @override
  State<MyGoal> createState() => _MyGoalState();
}

class _MyGoalState extends State<MyGoal> {

  Map<String,dynamic> goalListMap = {};
  var db = FirebaseFirestore.instance;

  void _loadGoals(){
    final docRef = db.collection("users_goals").doc(widget.Userdata['username']);
    docRef.get().then(
          (DocumentSnapshot doc) {
        setState(() {
          goalListMap = doc.data() as Map<String, dynamic>;
        });
        print(goalListMap);
      },
    );
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadGoals();

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
                          itemCount: goalListMap.length,
                          itemBuilder: (BuildContext context,int index){
                            return MyGoalCard(index,context,goalListMap,goalListMap.keys.toList());
                          }
                      ),
                    ),
                  )
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height - 310,
              left: MediaQuery.of(context).size.width - 60,
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
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AddGoal(widget.Userdata)));
                },
              ),
            )
          ]

      ),
    );
  }
  Widget MyGoalCard(int index, BuildContext context, Map<String, dynamic> yourGoalsMap,List yourGoalsList){
    return Container(
      margin: const EdgeInsets.only(left: 16,right: 16,bottom: 10,top: 10),
      width: MediaQuery.of(context).size.width,
      height: 113,
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
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              yourGoalsList[index],
              style: const TextStyle(
                fontFamily: 'JosefinSans',
                fontSize: 24,
                fontWeight: FontWeight.w400,
              ),
            ),
            InkWell(
              child: GradientIcon(
                  Icons.send,
                  25,
                  LinearGradient(
                    colors: [HexColor("#FB9F40"),HexColor("#ED1C24")]
                  )
              ),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateGoal(widget.Userdata,yourGoalsMap[yourGoalsList[index]])));
              },
            )
          ],
        ),
      )
    );
  }
}
