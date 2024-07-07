import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../../../models/CamModel.dart';
import '../../../shared/remote/api_manager.dart';
import '../admin_home.dart';
import '../drawer_screen.dart';
import '../update_road/latlng.dart';

class UpdateCameraMap extends StatefulWidget {
  final LatLng startPoint;
  final LatLng endPoint;
  final Camera CamRoad;
  final bool change_road;

  UpdateCameraMap({required this.startPoint, required this.endPoint, required this.CamRoad,required this.change_road});
  @override
  _AddCameraMapState createState() => _AddCameraMapState();
}

class _AddCameraMapState extends State<UpdateCameraMap> {
  List<Polyline> lstPolygone = [];
  List<Marker> markers = [];
  MapController mapController = MapController();
  LatLng? latlnglocal;


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
  void _addMarker(LatLng latlng) {
    print("Adding marker at: $latlng");
    // LatLng temp;
    // temp.latitude=latlng?.longitude;
    // temp.longitude!=latlng?.latitude;

     if (_isWithinBounds(LatLng(latlng.longitude,latlng.latitude))) {
      setState(() {
        markers.clear();
        markers.add(
          Marker(
            point:LatLng(latlng.longitude,latlng.latitude),
            width: 50,
            height: 50,
            child: Icon(
              Icons.location_on,
              color: Colors.green,
            ),
          ),
        );
        latlnglocal = LatLng(latlng.longitude,latlng.latitude);
      //  print("temppppppppppp${latlnglocal}");
      });
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Marker added successfully')),
        );
      });

      print("Markers: $markers");
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Marker is out of the specified bounds')),
      );
    }
  }


  void handleSubmit() async {
    if (latlnglocal != null) {
      String? temp = extractdescriptionFromAddress(widget.CamRoad.dimentions!) ;
      widget.CamRoad.dimentions = '$temp ${latlnglocal?.longitude}-${latlnglocal?.latitude}';
      print("Updated dimensions: ${widget.CamRoad.dimentions}");
      await ApiManager.updateCamera(widget.CamRoad);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AdminHome()),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Camera updated Successfully')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select a location on the road')),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    LatLng? latLngCamera;
    if(widget.change_road==false)
      latLngCamera= extractLatLngCameraLocation(widget.CamRoad.dimentions!);

    lstPolygone = [
      Polyline(
        points: [widget.startPoint, widget.endPoint],
        strokeWidth: 8.0,
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
    if(latLngCamera!=null){
      _addMarker(latLngCamera);
      latlnglocal=latLngCamera;
    print("hhhhhhhhhhh${latlnglocal}");
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
                  _addMarker(LatLng(latlng.longitude, latlng.latitude));
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
            child: Text('Save', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      endDrawer: DrawerScreen(),
    );
  }
}
