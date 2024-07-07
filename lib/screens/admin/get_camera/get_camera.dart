import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/models/RoadModel.dart';
import '../../../models/CamModel.dart';
import '../../../shared/remote/api_manager.dart';
import '../admin_home.dart';
import '../drawer_screen.dart';
import 'camera_item.dart';

class EditCamera extends StatefulWidget {
  static const String routName = "EditCamera";
  const EditCamera({super.key});

  @override
  _EditCameraState createState() => _EditCameraState();
}

class _EditCameraState extends State<EditCamera> {
  TextEditingController _searchController = TextEditingController();
  List<Camera> _cameras = [];
  List<Camera> _filteredCameras = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchCameras();
    _searchController.addListener(_filterCameras);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _fetchCameras() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    try {
      var result = await ApiManager.getCameras("camera/");
      setState(() {
        _cameras = result.camera ?? [];
        _filteredCameras = _cameras;
        _isLoading = false;
      });
    } catch (error) {
      setState(() {
        _errorMessage = 'Error fetching cameras: $error';
        _isLoading = false;
      });
    }
  }

  void _filterCameras() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      _filteredCameras = _cameras.where((camera) {
        return camera.model!.toLowerCase().contains(query) ||
            camera.id.toString().toLowerCase().contains(query) ||
            camera.startService.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AdminHome()),
            );
          },
        ),
        backgroundColor: Color.fromRGBO(14, 46, 92, 1),
        title: Text('Cameras'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
          SizedBox(height: 15),
          Expanded(
            child: _buildCamerasList(),
          ),
        ],
      ),
      endDrawer: DrawerScreen(),
    );
  }

  Widget _buildCamerasList() {
    if (_isLoading) {
      return Center(
        child: CircularProgressIndicator(color: Colors.blue),
      );
    }
    if (_errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_errorMessage!),
            TextButton(
              onPressed: _fetchCameras,
              child: const Text("Try again"),
            ),
          ],
        ),
      );
    }
    if (_filteredCameras.isEmpty) {
      return Center(child: Text('No cameras found'));
    } else {
      return ListView.builder(
        itemCount: _filteredCameras.length,
        itemBuilder: (context, index) {
          return CameraItem(_filteredCameras[index]);
        },
      );
    }
  }
}
