import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class GetRoadMap extends StatefulWidget {
  final LatLng startPoint;
  final LatLng endPoint;

  GetRoadMap({required this.startPoint, required this.endPoint});

  @override
  _GetRoadMapState createState() => _GetRoadMapState();
}

class _GetRoadMapState extends State<GetRoadMap> {
  List<Polyline> lstPolygone = [];
  MapController mapController = MapController();

  @override
  void initState() {
    super.initState();
    if (widget.startPoint != null && widget.endPoint != null) {
      lstPolygone = [
        Polyline(
          points: [widget.startPoint, widget.endPoint],
          strokeWidth: 4.0,
          color: Colors.blue,
        ),
      ];
      // Calculate the center point
      double centerLatitude = (widget.startPoint.latitude + widget.endPoint.latitude) / 2;
      double centerLongitude = (widget.startPoint.longitude + widget.endPoint.longitude) / 2;
      LatLng centerPoint = LatLng(centerLatitude, centerLongitude);
      // Zoom and center the map on the polyline
      WidgetsBinding.instance.addPostFrameCallback((_) {
        mapController.move(centerPoint, 10.0);
      });
    }
  }



@override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterMap(
        mapController: mapController,
        options: MapOptions(
          center:LatLng(30.0444, 31.2357),
          zoom: 8.0,

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
    );
  }
}
