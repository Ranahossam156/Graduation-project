import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:graduation_project/screens/admin/update_road/latlng.dart';
import 'package:latlong2/latlong.dart';

import '../../../models/RoadModel.dart';
import '../drawer_screen.dart';

class GetRoadMap extends StatefulWidget {
  final RoadModel road;


  GetRoadMap({required this.road});

  @override
  _GetRoadMapState createState() => _GetRoadMapState();
}

class _GetRoadMapState extends State<GetRoadMap> {

  List<Polyline> lstPolygone = [];
  MapController mapController = MapController();

  @override
  void initState() {
    super.initState();
    List<LatLng>latlng=extractLatLngFromAddress(widget!.road.address!);
    LatLng startPoint=latlng[0];
    LatLng endPoint=latlng[1];
    if (startPoint != null && endPoint != null) {
      lstPolygone = [
        Polyline(
          points: [startPoint, endPoint],
          strokeWidth: 4.0,
          color: Colors.blue,
        ),
      ];
      // Calculate the center point
      double centerLatitude = (startPoint.latitude + endPoint.latitude) / 2;
      double centerLongitude = (startPoint.longitude + endPoint.longitude) / 2;
      LatLng centerPoint = LatLng(centerLatitude, centerLongitude);
      // Zoom and center the map on the polyline
      WidgetsBinding.instance.addPostFrameCallback((_) {
        mapController.move(centerPoint, 14.0);
      });
    }
  }



@override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Color.fromRGBO(14, 46, 92, 1),
      //  title: Text('Road'),
      ),
      body: FlutterMap(
        mapController: mapController,
        options: MapOptions(
          center:LatLng(30.0444, 31.2357),
          zoom: 20.0,
          initialZoom: 14,

        ),
        children: [
          TileLayer(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
           // subdomains: ['a', 'b', 'c'],
          ),
          PolylineLayer(
            polylines: lstPolygone,
          ),
        ],
      ),
      endDrawer: DrawerScreen(),
    );
  }
}
