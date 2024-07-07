import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/models/RoadModel.dart';
import '../../../models/CamModel.dart';
import '../../../models/CamRoadModel.dart';
import '../../../shared/remote/api_manager.dart';
import '../drawer_screen.dart';
import 'RoadCamItem.dart';

class AddCamera extends StatelessWidget {
  static const String routeName = "showRoad";
  final Camera camRoad;
final bool update;
  const AddCamera({required this.camRoad,required this.update});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Specific Road'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Color.fromRGBO(14, 46, 92, 1),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 30),
          FutureBuilder<dynamic>(
            future: ApiManager.getRoads("road/"),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(color: Colors.blue),
                );
              }
              if (snapshot.hasError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(snapshot.error?.toString() ?? "An error occurred"),
                      TextButton(
                        onPressed: () {
                          // Retry logic
                        },
                        child: const Text("Try again"),
                      ),
                    ],
                  ),
                );
              }
              final roadModels = snapshot.data!;
              return Expanded(
                child: ListView.builder(
                  itemCount: roadModels.length,
                  itemBuilder: (context, index) {
                    return RoadCamItem(road: roadModels[index], CamRoad: camRoad,update: update,);
                  },
                ),
              );
            },
          ),
        ],
      ),
      endDrawer: DrawerScreen(),
    );
  }
}
