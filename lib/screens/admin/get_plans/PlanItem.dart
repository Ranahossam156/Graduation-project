import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:graduation_project/models/PlanModel.dart';
import '../update_plan/UpdatePlan.dart';
import 'GetSubscriotionsPlan.dart';


class PlanItem extends StatelessWidget {

  Plans plan ;

  PlanItem  (this.plan,{super.key});


  @override
  Widget build(BuildContext context) {
    return Card (
      color: Color.fromRGBO(14,46,92,1),
      elevation: 20,
      margin: EdgeInsets.symmetric(horizontal: 25,vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: Colors.transparent)),
       child: Slidable(
         startActionPane: ActionPane(motion: DrawerMotion(),
           children: [
            SlidableAction(onPressed: (BuildContext cotext)  {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SubscriptionsPlanPage(plan.id!)),
              );
            },
              spacing: 15,
              backgroundColor: Colors.blueGrey,
              // label: "Delete",
              icon: Icons.person_2_sharp,
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12),
                  topLeft:Radius.circular(12) ),
            ),
            SlidableAction(onPressed: (BuildContext cotext){
              print("${plan.id}");

              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UpdatePlan(plan)),
              );
            },
              spacing: 15,
              backgroundColor: Color.fromRGBO(151,213,201,1),
              // label: "Edit",
              icon:  Icons.edit_outlined,

            )
          ],),

        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Center(
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Container(
                    height: 100,
                    width: 2,
                    decoration:BoxDecoration(

                      color:Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color:Colors.white),
                    )),
               SizedBox(width:10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // SizedBox(
                      //   height: 31,
                      // ),
                      Text("Plan ID : ${plan?.id??0}",style: TextStyle(
                        fontSize:17,
                       // fontWeight: FontWeight.w500,
                        color:Colors.white,)),
                      SizedBox(height: 5,),
                      Text("Name : ${plan?.name ?? 'No Name'}",style: TextStyle(
                        fontSize:17,
                        //fontWeight: FontWeight.w500,
                        color:Colors.white,)),
                      SizedBox(height: 5,),

                      // SizedBox(width: 5,),
                      Text("Description : ${plan?.description ?? 'No Description'}",style: TextStyle(
                        fontSize:17,
                       // fontWeight: FontWeight.w500,
                        color:Colors.white,)),
                      SizedBox(height: 5,),

                      // SizedBox(width: 5,),
                      Text("Price : ${plan?.price??0}",style: TextStyle(
                        fontSize:17,
                        // fontWeight: FontWeight.w500,
                        color:Colors.white,)),
                      Text("Subscription duration : ${plan?.periodInDays??0}",style: TextStyle(
                        fontSize:17,
                      //   fontWeight: FontWeight.w500,
                        color:Colors.white,)),
                      Text("Discount : ${plan?.discount??0.0}",style: TextStyle(
                        fontSize:17,
                      //  fontWeight: FontWeight.w500,
                        color:Colors.white,)),
                      // Text(camera.location,style: TextStyle(fontSize:25,
                      //   fontWeight: FontWeight.w500,
                      //   color:Colors.white,
                      //
                      // ),)

                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
