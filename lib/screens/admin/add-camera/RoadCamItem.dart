

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:latlong2/latlong.dart';
import '../../../models/CamModel.dart';
import '../../../models/RoadModel.dart';
import '../update-camera/UpdateCameraMap.dart';
import '../update_road/latlng.dart';
import 'AddCameraMap.dart';



class RoadCamItem extends StatelessWidget {
  final RoadModel road;
  final Camera CamRoad;
  final bool update;

  RoadCamItem ({required  this.road,required this.CamRoad,required this.update});


  @override
  Widget build(BuildContext context) {
    List<LatLng> latLngList = extractLatLngFromAddress(road.address!);
//print("jjjjjjjjjjj${latLngList[0]}    ${latLngList[1]}");
//     LatLng? stPoint = (latLngList.isNotEmpty ? latLngList[0] : null);
//     LatLng? endPoint = (latLngList.length > 1 ? latLngList[1] : null);
    return MaterialButton(

        onPressed:() {
          CamRoad.road_id=road.id;
          if(update==false)
          {Navigator.push(context, MaterialPageRoute(builder: (context) => AddCameraMap(startPoint: latLngList[0],endPoint: latLngList[1],CamRoad: CamRoad,)));}
          else
           { Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateCameraMap(
              startPoint: latLngList[0],
              endPoint: latLngList[1],
              CamRoad:CamRoad,
             change_road: true,
            )));}

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
                // print("hhhhhhhhhhh${latLngList[0]}");
                CamRoad.road_id=road.id;
                if(update==false)
                {Navigator.push(context, MaterialPageRoute(builder: (context) => AddCameraMap(startPoint: latLngList[0],endPoint: latLngList[1],CamRoad: CamRoad,)));}
                else
                { Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateCameraMap(
                  startPoint: latLngList[0],
                  endPoint: latLngList[1],
                  CamRoad:CamRoad,
                  change_road: true,
                )));}
                // FirebaseManager.editTask(task);
              },
                spacing: 15,
                backgroundColor: Colors.grey,
                // label: "Edit",
                icon:  Icons.add_a_photo_sharp,

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
                        Text("Road ID : ${road.id??"no"}",style: TextStyle(fontSize: 17,
                         // fontWeight: FontWeight.w500,
                          color:Colors.white,)),
                        SizedBox(height: 5,),
                        Text("Name : ${road.name??"no"}",style: TextStyle(fontSize: 17,
                        //  fontWeight: FontWeight.w500,
                          color:Colors.white,)),
                        SizedBox(width: 5,),
                        Text("Address : ${extractdescriptionFromAddress(road.address??"no")}",style: TextStyle(fontSize: 17,
                      //    fontWeight: FontWeight.w500,
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
      ),
    );
  }
}
