import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:graduation_project/models/UserModel.dart';

import 'UserDetailsScreen.dart';


class UserItem extends StatelessWidget {

  Result user ;
  //RoadModel road;
  UserItem (this.user,{super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialButton(

      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => UserDetailsScreen(user: user,)));
      },
      child: Card (
        color: Color.fromRGBO(14,46,92,1),
        elevation: 12,
       margin: EdgeInsets.symmetric(horizontal: 10,vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),
            side: BorderSide(color: Colors.transparent)),
        child: Slidable(
          startActionPane: ActionPane(motion: DrawerMotion(),
            children: [

              SlidableAction(onPressed: (BuildContext cotext){

               Navigator.push(context, MaterialPageRoute(builder: (context) => UserDetailsScreen(user: user,)));

              },
                // spacing: 5,
                backgroundColor:Colors.blueGrey,
                // label: "Edit",
                icon:  Icons.person_2_sharp,

              )
            ],),

          // child: Column(
          //   children: [
          //     Text(camera.id),
          //     Text(camera.location),
          //   ],
          //
          // )
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Center(
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
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

                          Text("Name : ${user.name}",style: TextStyle(fontSize: 17,
                        //  fontWeight: FontWeight.w500,
                          color:Colors.white,)),
                        SizedBox(height: 5,),
                        Text("Email : ${user.email}",style: TextStyle(fontSize: 17,
                        //  fontWeight: FontWeight.w500,
                          color:Colors.white,)),
                        SizedBox(height: 5,),
                        // SizedBox(width: 5,),
                        Text("Address : ${user.address??"No Address"}",style: TextStyle(fontSize: 17,
                      //    fontWeight: FontWeight.w500,
                          color:Colors.white,)),
                      ],
                    ),
                  ),
                  // Spacer(),
                  // InkWell(
                  //   onTap: (){
                  //   //  FirebaseManager.updateTask(task.id, true);
                  //   },
                  //   child: Container(
                  //     width: 69,
                  //     height: 34,
                  //     decoration: BoxDecoration(
                  //     //    color:task.isDone?Colors.transparent:  primary,
                  //         borderRadius: BorderRadius.circular(12)
                  //     ),
                  //     // child:task.isDone?Text("Done!",style: TextStyle(
                  //     //     color: Color(0xFF61E757),fontWeight:FontWeight.w600,fontSize: 22 ),
                  //      // textAlign: TextAlign.center,) :
                  //   //  Icon(Icons.done,color: Colors.white,size: 28),
                  //   ),
                  // )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
