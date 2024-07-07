import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../../../models/RoadModel.dart';
import '../drawer_screen.dart';
import 'latlng.dart';

class EditRoadMap extends StatefulWidget {
  final Function(LatLng) setSTPoint;
  final Function(LatLng) setENDPoint;
  final LatLng? startPoint;
  final LatLng? endPoint;

  EditRoadMap({
    required this.setSTPoint,
    required this.setENDPoint,
    required this.startPoint,
    required this.endPoint,
  });

  @override
  _EditRoadMapState createState() => _EditRoadMapState();
}

class _EditRoadMapState extends State<EditRoadMap> {
  LatLng? startPoint;
  LatLng? endPoint;

  List<Polyline> lstPolylines = [];
  final MapController mapController = MapController();
  //String address1 = extractdescriptionFromAddress(road.address!);
  @override
  void initState() {
    super.initState();
    startPoint = widget.startPoint;
    endPoint = widget.endPoint;
    if (startPoint != null && endPoint != null) {
      _updatePolylines();
      WidgetsBinding.instance.addPostFrameCallback((_) => _centerMapOnPolyline());
    }
  }

  void _updatePolylines() {
   // setState(() {
      if (startPoint != null && endPoint != null) {
        lstPolylines = [
          Polyline(
            points: [startPoint!, endPoint!],
            strokeWidth: 4.0,
            color: Colors.blue,
          ),
        ];
      }
  //  });
  }

  void _centerMapOnPolyline() {
    if (startPoint != null && endPoint != null) {
      double centerLatitude = (startPoint!.latitude + endPoint!.latitude) / 2;
      double centerLongitude = (startPoint!.longitude + endPoint!.longitude) / 2;
      LatLng centerPoint = LatLng(centerLatitude, centerLongitude);
    //  widget.road?.address='${widget.address} ${startPoint!.latitude}-${startPoint!.longitude} ${endPoint!.latitude}-${endPoint!.longitude}';
      mapController.move(centerPoint, 14.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterMap(
     //   key: UniqueKey(),
        mapController: mapController,
        options: MapOptions(
          center: LatLng(30.0444, 31.2357),
          zoom: 8.0,
          onTap: (_, point) {
            setState(() {
              if (startPoint == null) {
                startPoint = point;
                widget.setSTPoint(point);
              } else if (endPoint == null) {
                endPoint = point;
                widget.setENDPoint(point);
                _updatePolylines();
                _centerMapOnPolyline();
              } else {
                startPoint = null;
                endPoint = null;
                lstPolylines.clear();
             //   widget.setSTPoint(point);


              }
            });
          },
        ),
        children: [
          TileLayer(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c'],
            // errorTileCallback:  (tile, error, stackTrace) {
            //   print('Failed to load tile: $tile - Error: $error');
            // },
          ),
          PolylineLayer(
            polylines: lstPolylines,
          ),
        ],
      ),
      endDrawer: DrawerScreen(),
    );
  }
}
