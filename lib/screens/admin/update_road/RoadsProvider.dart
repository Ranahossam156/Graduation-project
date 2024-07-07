// import 'package:flutter/material.dart';
// import 'package:graduation_project/shared/remote/api_manager.dart';
//
// import '../../../models/RoadModel.dart';
//
// class RoadsProvider with ChangeNotifier {
//   Future<void> addNewRoad(RoadModel newRoad) async {
//     ApiManager roadService = ApiManager();
//     await roadService.PostRoad (newRoad);
//     await Future.delayed(Duration(seconds: 2)); // Simulate a network call
//     notifyListeners();
//   }
// }
