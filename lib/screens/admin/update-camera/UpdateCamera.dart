import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/shared/remote/api_manager.dart';
import 'package:latlong2/latlong.dart';

import '../../../models/CamRoadModel.dart';
import '../../../models/RoadModel.dart';
import '../update_road/latlng.dart';
import 'UpdateCameraMap.dart';
import 'UpdateCamera_Form.dart';

class UpdateCamera extends StatefulWidget {
  final CamRoadModel camera;
  UpdateCamera({required this.camera});

  @override
  _UpdateCameraState createState() => _UpdateCameraState();
}

class _UpdateCameraState extends State<UpdateCamera> {
  late Future<RoadModel> futureCamRoadModel;

  @override
  void initState() {
    super.initState();
    futureCamRoadModel = ApiManager.getSpecificRoad(
      'road/${widget.camera.roadCamera?.roadId}', // Replace with your actual endpoint
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<RoadModel>(
      future: futureCamRoadModel,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          RoadModel camRoadModel = snapshot.data!;
          // print('RoadModel data: ${camRoadModel.toJson()}');  // Debug: Print RoadModel data
          if (camRoadModel.address != null) {
            List<LatLng> latLngList = extractLatLngFromAddress(camRoadModel.address!);
            return UpdateCameraMap(
              startPoint: latLngList[0],
              endPoint: latLngList[1],
              CamRoad: widget.camera.camera!,
              change_road: false,
            );
          } else {
            return Center(child: Text('Address is null'));
          }
        } else {
          return Center(child: Text('No data found'));
        }
      },
    );
  }

}