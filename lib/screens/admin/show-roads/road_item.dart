import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:graduation_project/screens/admin/admin_home.dart';
import '../../../models/RoadModel.dart';
import '../../../shared/remote/api_manager.dart';
import '../update_road/edit_road.dart';
import 'bottom_sheetRoad.dart';



class RoadItem extends StatelessWidget {
  RoadModel road;
  RoadItem (this.road,{super.key});


  @override
  Widget build(BuildContext context) {
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
              await ApiManager.deleteRoad(road.id!);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AdminHome()),
              );

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Road Deleted Successfully')),

              );
            },
              spacing: 15,
              backgroundColor: Color.fromRGBO(255,110,93,1),
             // label: "Delete",
              icon: Icons.delete_outline,
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12),
                  topLeft:Radius.circular(12) ),
            ),
            SlidableAction(onPressed: (BuildContext cotext){

              Navigator.push(context, MaterialPageRoute(builder: (context) => EditRoad(road: road,)));
            //  BottomSheet
              // FirebaseManager.editTask(task);
            },
              spacing: 15,
              backgroundColor: Color.fromRGBO(151,213,201,1),
              // label: "Edit",
              icon:  Icons.edit_outlined,

            ),

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
                      // SizedBox(
                      //   height: 31,
                      // ),
                      Text("Road ID : ${road.id??"no"}",style: TextStyle(fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color:Colors.white,)),
                      SizedBox(height: 5,),
                      Text("Name : ${road.name??"no"}",style: TextStyle(fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color:Colors.white,)),
                      SizedBox(width: 5,),
                      Text("Address : ${road.address??"no"}",style: TextStyle(fontSize: 20,
                        fontWeight: FontWeight.w500,
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
