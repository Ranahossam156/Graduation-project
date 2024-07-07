import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/shared/remote/api_manager.dart';

import '../../../models/CamModel.dart';
import '../../../models/CamRoadModel.dart';
import 'UpdateCamera_Form.dart';

class SpecificCam extends StatefulWidget {

  final Camera camera;
  SpecificCam ({ required this.camera});
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<SpecificCam> {
  late Future<CamRoadModel> futureCamRoadModel;

  @override
  void initState() {
    super.initState();
    int? id=widget.camera.id;
    futureCamRoadModel = ApiManager.getSpecificCamera(
      'camera/${id}', // Replace with your actual endpoint
    );
  }

  @override
  Widget build(BuildContext context) {
    return
          FutureBuilder<CamRoadModel>(
            future: futureCamRoadModel,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (snapshot.hasData) {
                CamRoadModel camRoadModel = snapshot.data!;
                return UpdateCameraForm(cam: camRoadModel,);
              } else {
                return Center(child: Text('No data found'));
              }
            },
          );

  }
}