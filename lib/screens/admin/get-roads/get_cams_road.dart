// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:graduation_project/models/RoadModel.dart';
// import 'package:graduation_project/screens/admin/get-roads/road_cam_list.dart';
// import '../../../models/CamerasRoadModel.dart';
// import '../../../shared/remote/api_manager.dart';
// import '../add-camera/RoadCamItem.dart';
// import '../admin_home.dart';
// import '../drawer_screen.dart';
// import 'road_item.dart';
//
// class GetCamsRoad extends StatelessWidget {
//   static const String routName="showRoad";
//
//  final RoadModel road;
//
//   const GetCamsRoad(this.road,{super.key});
//
//   @override
//   Widget build(BuildContext context) {
//
//     return Scaffold(
//
//       appBar: AppBar(
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: Colors.white),
//           onPressed:() {Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => AdminHome()));},
//         ),
//         backgroundColor: Color.fromRGBO(14,46,92,1),
//       ),
//       body: Column(
//
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: <Widget>[
//           SizedBox(height: 30),
//
//           FutureBuilder<List<CamerasRoadModel>>(
//             future: ApiManager.getCamRoads("camera/cameras/${road.id}"),
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return const Center(
//                   child: CircularProgressIndicator(color: Colors.blue),
//                 );
//               }
//               if (snapshot.hasError) {
//                 return Center(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(snapshot.error?.toString() ?? "An error occurred"),
//                       TextButton(
//                         onPressed: () {
//                           // Retry logic
//                         },
//                         child: const Text("Try again"),
//                       ),
//                     ],
//                   ),
//                 );
//               }
//               final roadModels = snapshot.data!;
//               return Expanded(
//                 child: ListView.builder(
//                   itemCount: roadModels.length,
//                   itemBuilder: (context, index) {
//                     return RoadCamerasItem(roadModels[index],);
//                   },
//                 ),
//               );
//             },
//           ),
//
//         ],
//       ),
//       endDrawer: DrawerScreen(),
//     );
//
//   }
// }
