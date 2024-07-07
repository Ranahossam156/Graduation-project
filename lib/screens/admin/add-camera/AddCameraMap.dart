import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../../../models/CamModel.dart';
import '../../../models/CamRoadModel.dart';
import '../../../shared/remote/api_manager.dart';
import '../admin_home.dart';
import '../drawer_screen.dart';

class AddCameraMap extends StatefulWidget {
  final LatLng startPoint;
  final LatLng endPoint;
  final Camera CamRoad;
  AddCameraMap({required this.startPoint, required this.endPoint, required this.CamRoad});

  @override
  _AddCameraMapState createState() => _AddCameraMapState();
}

class _AddCameraMapState extends State<AddCameraMap> {
  List<Polyline> lstPolygone = [];
  List<Marker> markers = [];
  MapController mapController = MapController();
  LatLng? latlnglocal;

  @override
  void initState() {
    super.initState();
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
      mapController.move(centerPoint, 14.0);
    });
  }

  void _addMarker(LatLng latlng) {
    print("Adding marker at: $latlng"); // Debug logging
    if (_isWithinBounds(latlng)) {
      setState(() {
        markers.clear();
        markers.add(
          Marker(
            point: latlng,
            width: 50,
            height: 50,
            child: Icon(
              Icons.location_on,
              color: Colors.green,
            ),
          ),
        );
        latlnglocal = latlng; // Assign the value here
      });
      print("Markers: $markers"); // Debug logging
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Marker is out of the specified bounds')),
      );
    }
  }

  bool _isWithinBounds(LatLng point) {
    double minLat = widget.startPoint.latitude < widget.endPoint.latitude
        ? widget.startPoint.latitude
        : widget.endPoint.latitude;
    double maxLat = widget.startPoint.latitude > widget.endPoint.latitude
        ? widget.startPoint.latitude
        : widget.endPoint.latitude;
    double minLng = widget.startPoint.longitude < widget.endPoint.longitude
        ? widget.startPoint.longitude
        : widget.endPoint.longitude;
    double maxLng = widget.startPoint.longitude > widget.endPoint.longitude
        ? widget.startPoint.longitude
        : widget.endPoint.longitude;

    return point.latitude >= minLat &&
        point.latitude <= maxLat &&
        point.longitude >= minLng &&
        point.longitude <= maxLng;
  }

  void handleSubmit() async {
    if (latlnglocal != null) {
      String? temp = widget.CamRoad.dimentions;
      widget.CamRoad.dimentions = '$temp ${latlnglocal?.longitude}-${latlnglocal?.latitude}';
      print("Updated dimensions: ${widget.CamRoad.dimentions}");

      // Camera camera = Camera(
      //   active: widget.CamRoad.active,
      //   model: widget.CamRoad.model,
      //   road_id: widget.CamRoad.road_id,
      //   dimentions: widget.CamRoad.dimentions,
      //   factory: widget.CamRoad.factory,
      //   endService: widget.CamRoad.endService,
      //   startService: widget.CamRoad.startService,
      // );

      await ApiManager.PostCam ( widget.CamRoad);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AdminHome()),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('New Camera is Added Successfully')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select a location on the road')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Set Camera Location'),
        backgroundColor: Color.fromRGBO(14, 46, 92, 1),
      ),
      body: Column(
        children: [
          Expanded(
            child: FlutterMap(
              mapController: mapController,
              options: MapOptions(
                center: LatLng(30.0444, 31.2357),
                zoom: 8.0,
                onTap: (tapPosition, latlng) {
                  print("${latlng.latitude}-${latlng.longitude} tapped");
                  _addMarker(latlng);
                },
              ),
              children: [
                TileLayer(
                  urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                ),
                PolylineLayer(
                  polylines: lstPolygone,
                ),
                MarkerLayer(
                  markers: markers,
                ),
              ],
            ),
          ),
          MaterialButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            color: Color.fromRGBO(14, 46, 92, 1),
            onPressed: handleSubmit,
            child: Text('Add', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      endDrawer: DrawerScreen(),
    );
  }
}
