import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/models/RoadModel.dart';
import '../../../shared/remote/api_manager.dart';
import '../admin_home.dart';
import '../drawer_screen.dart';
import '../update_road/latlng.dart';
import 'road_item.dart';

class ShowRoad extends StatefulWidget {
  static const String routName = "showRoad";
  const ShowRoad({super.key});

  @override
  _ShowRoadState createState() => _ShowRoadState();
}

class _ShowRoadState extends State<ShowRoad> {
  TextEditingController _searchController = TextEditingController();
  List<RoadModel> _roads = [];
  List<RoadModel> _filteredRoads = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchRoads();
    _searchController.addListener(_filterRoads);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _fetchRoads() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    try {
      var response = await ApiManager.getRoads("road/");
      setState(() {
        _roads = response;
        _filteredRoads = _roads;
        _isLoading = false;
      });
    } catch (error) {
      setState(() {
        _errorMessage = 'Error fetching roads: $error';
        _isLoading = false;
      });
    }
  }

  void _filterRoads() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      _filteredRoads = _roads.where((road) {
        return road.id.toString().toLowerCase().contains(query) ||
            road.name.toString().toLowerCase().contains(query) ||
            extractdescriptionFromAddress(road.address!).toLowerCase().contains(query);
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
        title: Text('Roads'),
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
            child: _buildRoadsList(),
          ),
        ],
      ),
      endDrawer: DrawerScreen(),
    );
  }

  Widget _buildRoadsList() {
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
              onPressed: _fetchRoads,
              child: const Text("Try again"),
            ),
          ],
        ),
      );
    }
    if (_filteredRoads.isEmpty) {
      return Center(child: Text('No roads found'));
    } else {
      return ListView.builder(
        itemCount: _filteredRoads.length,
        itemBuilder: (context, index) {
          return RoadItem(_filteredRoads[index]);
        },
      );
    }
  }
}
