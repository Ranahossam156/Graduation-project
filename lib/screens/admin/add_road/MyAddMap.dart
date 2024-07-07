import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../drawer_screen.dart';

class MyAddMap extends StatefulWidget {
  final Function(LatLng?) setSTPoint;
  final Function(LatLng?) setENDPoint;
  final LatLng setcenterPoint;

  MyAddMap({required this.setSTPoint, required this.setENDPoint, required this.setcenterPoint});

  @override
  _MyAddMapState createState() => _MyAddMapState();
}

class _MyAddMapState extends State<MyAddMap> {
  LatLng? startPoint;
  LatLng? endPoint;
  late MapController mapController;
  List<Polyline> lstPolygone = [];

  @override
  void initState() {
    super.initState();
    mapController = MapController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      mapController.move(widget.setcenterPoint, 14);
    });
    print("initState: centerPoint = ${widget.setcenterPoint}");
  }

  @override
  void didUpdateWidget(covariant MyAddMap oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Update centerPoint when the widget is updated
    if (oldWidget.setcenterPoint != widget.setcenterPoint) {
      mapController.move(widget.setcenterPoint, 14);
      print("didUpdateWidget: centerPoint updated to ${widget.setcenterPoint}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FlutterMap(
          mapController: mapController,
          options: MapOptions(
            center: widget.setcenterPoint,
            zoom: 12.0,
            enableScrollWheel: true,
            initialZoom: 8,
            onTap: (_, point) {
              setState(() {
                bool flag = false;
                if (startPoint == null) {
                  startPoint = point;
                  widget.setSTPoint(point);
                } else if (endPoint == null) {
                  endPoint = point;
                  widget.setENDPoint(point);

                  // Adding the polyline between start and end points
                  if (startPoint != null && endPoint != null && !flag) {
                    lstPolygone = [
                      Polyline(
                        points: [startPoint!, endPoint!],
                        strokeWidth: 4.0,
                        color: Colors.blue,
                      )
                    ];
                  }
                } else {
                  startPoint = point;
                  widget.setSTPoint(point);
                  endPoint = null;
                  widget.setENDPoint(null);
                }
              });
            },
          ),
          children: [
            TileLayer(
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: ['a', 'b', 'c'],
            ),
            PolylineLayer(
              polylines: lstPolygone,
            ),
          ],
        ),
      ),
      endDrawer: DrawerScreen(),
    );
  }
}
