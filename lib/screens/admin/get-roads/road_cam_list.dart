import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/screens/admin/update_road/latlng.dart';
import 'package:graduation_project/shared/remote/api_manager.dart';
import 'package:latlong2/latlong.dart';

import '../../../models/CamRoadModel.dart';
import '../../../models/RoadModel.dart';
import '../drawer_screen.dart';
import 'Cameras_Road_Map.dart';

class CameraListScreen extends StatefulWidget {
  final RoadModel id;

  CameraListScreen(this.id, {super.key});
  @override
  _CameraListScreenState createState() => _CameraListScreenState();
}

class _CameraListScreenState extends State<CameraListScreen> {
  late dynamic futureCameras;
  late List<LatLng> locations; // Initialize as a non-nullable list

  @override
  void initState() {
    super.initState();
    futureCameras = ApiManager().fetchCameras(widget.id.id!);
    locations = []; // Initialize the list here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:  Color.fromRGBO(14, 46, 92, 1),
        title: Text('Cameras'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          FutureBuilder<dynamic>(
            future: futureCameras,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (snapshot.hasData) {
                locations.clear(); // Clear the list before adding new items
                return Expanded( // Wrap with Expanded to avoid layout issues
                  child: ListView.builder(
                    itemCount: snapshot.data!.allCameras.length,
                    itemBuilder: (context, index) {
                      final cameraData = snapshot.data!.allCameras[index];
                      locations.add(extractLatLngCameraLocation(cameraData.roadCam.dimensions));
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                           // SizedBox(height: 4,),
                            ListTile(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                                side: BorderSide(color: Colors.transparent),
                              ),
                              tileColor: Color.fromRGBO(14, 46, 92, 1),
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 4,),
                                  Text('ID : ${cameraData.cameraDetails.id}',
                                      style: TextStyle(color: Colors.white)),
                                  SizedBox(height: 4,),
                                  Text('Model : ${cameraData.cameraDetails.model}',
                                      style: TextStyle(color: Colors.white)),
                                  SizedBox(height: 4,),
                                  Text('Dimensions : ${cameraData.roadCam.dimensions}',
                                      style: TextStyle(color: Colors.white)),
                     SizedBox(height: 4,),
                                ],
                              ),


                              trailing: Text(
                                  cameraData.roadCam.active ? 'Active' : 'Inactive',
                                  style: TextStyle(color: Colors.white)),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              } else {
                return Center(child: Text('No data'));
              }
            },
          ),
          MaterialButton(
            elevation: 20,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            color: Color.fromRGBO(14, 46, 92, 1),
            onPressed: () {
              List<LatLng> road = extractLatLngFromAddress(widget.id.address!);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CamerasRoadMap(
                    startPoint: road[0],
                    endPoint: road[1],
                    latLngCamera: locations,
                  ),
                ),
              );
            },
            child: Text('View on the road', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      endDrawer: DrawerScreen(),
    );
  }
}
