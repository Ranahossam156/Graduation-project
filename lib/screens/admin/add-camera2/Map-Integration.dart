import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';


class CameraMap extends StatefulWidget {
  @override
  _CameraMapState createState() => _CameraMapState();
}

class _CameraMapState extends State<CameraMap> {
  LatLng? _markerPosition;

  @override
  Widget build(BuildContext context) {
    //final cameraProvider = Provider.of<CameraProvider>(context);
  //  final camera = cameraProvider.camera;

    return Scaffold(
      appBar: AppBar(title: Text('Camera Map')),
      body: FlutterMap(
        options: MapOptions(
          center: LatLng(30.0444, 31.2357),
          zoom: 11,
          onTap: (tapPosition, point) {
            setState(() {
              _markerPosition = point;
            });
           // camera.location = '${point.latitude}-${point.longitude}';
           // cameraProvider.updateCamera(camera);
          },
        ),
        children: [
          TileLayer(
            urlTemplate:
            'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: ['a', 'b', 'c'],
          ),
          if (_markerPosition != null)
            MarkerLayer(
              markers: [
                Marker(
                  point: _markerPosition!,
                  child: Icon(
                    Icons.location_on,
                    color: Colors.red,
                    size: 40,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
