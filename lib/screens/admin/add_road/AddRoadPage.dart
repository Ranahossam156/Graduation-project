import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:graduation_project/screens/admin/admin_home.dart';
import 'package:graduation_project/shared/remote/api_manager.dart';
import 'package:latlong2/latlong.dart';
import '../../../models/RoadModel.dart';
import '../../../shared/style/gradient_divider.dart';
import '../../../shared/style/text_field.dart';
import '../drawer_screen.dart';
import 'MyAddMap.dart';
import 'package:http/http.dart' as http;

class AddRoadPage extends StatefulWidget {
  static const String routName = "AddRoad";

  @override
  _AddRoadPageState createState() => _AddRoadPageState();
}

class _AddRoadPageState extends State<AddRoadPage> {
  final formKey = GlobalKey<FormState>();
  final roadNameController = TextEditingController();
  final addressController = TextEditingController();
  LatLng? stPoint;
  LatLng? endPoint;
  bool loading = false;
  LatLng centerPoint = LatLng(30.0444, 31.2357); // Initialize centerPoint

  @override
  void dispose() {
    roadNameController.dispose();
    addressController.dispose();
    super.dispose();
  }

  Future<void> handleSearch() async {
    if (addressController.text.isNotEmpty) {
      try {
        final response = await http.get(Uri.parse(
            'https://nominatim.openstreetmap.org/search?q=${Uri.encodeComponent(addressController.text)}&format=json'));

        if (response.statusCode == 200) {
          var results = json.decode(response.body);
          if (results != null && results.isNotEmpty) {
            double lat = double.parse(results[0]['lat']);
            double lon = double.parse(results[0]['lon']);
            setState(() {
              centerPoint = LatLng(lat, lon); // Update centerPoint
            });
            print("New center point: $centerPoint");
          } else {
            print('No results found for the search query.');
          }
        } else {
          print('Error fetching data: ${response.statusCode}');
        }
      } catch (error) {
        print('Error fetching data: $error');
      }
    }
  }

  void handleSubmit() async {
    if (formKey.currentState?.validate() ?? false) {
      if (stPoint == null || endPoint == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please set a start point and end point on the map')),
        );
        return;
      }

      final RoadModel newRoad = RoadModel(
        name: roadNameController.text,
        address: '${addressController.text} ${stPoint?.latitude}-${stPoint?.longitude} ${endPoint?.latitude}-${endPoint?.longitude}',
      );

      setState(() {
        loading = true;
      });

      await ApiManager.PostRoad(newRoad);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AdminHome()),
      );

      setState(() {
        loading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('New Road is Added Successfully')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Road'),
        backgroundColor: Color.fromRGBO(14, 46, 92, 1),
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : Form(
        key: formKey,
        child: Column(
          children: [
            SizedBox(height: 10),
            CustomTextFormField(
              textColor: Color.fromRGBO(14, 46, 92, 1),
              labelText: 'Road Name',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the road name';
                }
                return null;
              },
              controller: roadNameController,
              keyboardType: TextInputType.text,
            ),
            GradientDivider(),
            SizedBox(height: 10),
            CustomTextFormField(
              textColor: Color.fromRGBO(14, 46, 92, 1),
              labelText: 'Address',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the address';
                }
                return null;
              },
              controller: addressController,
              keyboardType: TextInputType.text,
              iconData: Icons.search,
              onPressed: () {
                handleSearch();
                print('Search button pressed');
              },
            ),
            GradientDivider(),
            Expanded(
              child: MyAddMap(
                setSTPoint: (point) => setState(() {
                  stPoint = point;
                }),
                setENDPoint: (point) => setState(() {
                  endPoint = point;
                }),
                setcenterPoint: centerPoint,
              ),
            ),
            MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              color: Color.fromRGBO(14, 46, 92, 1),
              onPressed: () {
                handleSubmit();
              },
              child: Text('Add', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
      endDrawer: DrawerScreen(),
    );
  }
}
