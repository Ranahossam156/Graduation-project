import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:graduation_project/models/PlanModel.dart';
import 'package:graduation_project/models/SubscribtionsModel.dart';

import '../../../models/UserModel.dart';
import '../../../shared/remote/api_manager.dart';
import '../admin_home.dart';
import '../all_users/UserDetailsScreen.dart';
import '../get_plans/PlanItem.dart';


class SubscribtionsPlanItem extends StatelessWidget {

  SubscriptionModel sub ;

  SubscribtionsPlanItem (this.sub,{super.key});


  @override
  Widget build(BuildContext context) {

    Result? user;
    return Card (
      color: Color.fromRGBO(14,46,92,1),
      elevation: 12,
      margin: EdgeInsets.symmetric(horizontal: 25,vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: Colors.transparent)),
      child: Slidable(
        startActionPane: ActionPane(motion: DrawerMotion(),
          children: [

            SlidableAction(onPressed: (BuildContext cotext) async {

              print("${sub.id}");
              try {
                 user = await ApiManager().fetchUserData("user/${sub.userId}");
              } catch (e) {
                print('Error: $e');
              }
              Navigator.push(context, MaterialPageRoute(builder: (context) => UserDetailsScreen(user: user!,)));
            },
              spacing: 15,
              backgroundColor:Colors.blueGrey,
              icon:  Icons.person_2_sharp,

            )
          ],),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Center(
            child: Row(
              children: [
                Container(
                    height: 60,
                    width: 3,
                    decoration:BoxDecoration(

                      color:Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color:Colors.white),
                    )),
                SizedBox(width:20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("User ID : ${sub.userId}",style: TextStyle(fontSize: 17,
                       // fontWeight: FontWeight.w500,
                        color:Colors.white,)),

                      // SizedBox(width: 5,),
                      // Text("Plan ID : ${sub.planId}",style: TextStyle(fontSize: 20,
                      //   fontWeight: FontWeight.w500,
                      //   color:Colors.white,)),
                      SizedBox(height: 5,),
                      Text("Start Date : ${sub.startDate}",style: TextStyle(fontSize: 17,
                       // fontWeight: FontWeight.w500,
                        color:Colors.white,)),
                      SizedBox(height: 5,),
                      Text("End Date : ${sub.endDate}",style: TextStyle(fontSize: 17,
                       // fontWeight: FontWeight.w500,
                        color:Colors.white,)),
                      SizedBox(height: 5,),

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
