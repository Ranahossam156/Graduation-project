// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// class EditBottomSheet extends StatefulWidget {
//
//   static const String routName="bottom";
//
//   @override
//   State<EditBottomSheet> createState() => _EditBottomSheetState();
//
// }
//
// class _EditBottomSheetState extends State<EditBottomSheet> {
//
//   var locationController = TextEditingController();
//   var idController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return
//       Scaffold(
//         appBar: AppBar(
//           leading: IconButton(
//             icon: Icon(Icons.arrow_back, color: Colors.white),
//             onPressed: () => Navigator.of(context).pop(),
//           ),
//           backgroundColor: Color.fromRGBO(14,46,92,1),
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(25.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               TextField(
//                 controller:idController ,
//                 decoration: InputDecoration(
//                   labelText: 'Enter CameraID',
//
//                 ),
//                 maxLines: null, // Allow multiple lines of text
//               ),
//               SizedBox(height: 20),
//               TextField(
//                 controller:idController ,
//                 decoration: InputDecoration(
//                   labelText: 'Enter Location',
//                 ),
//                 maxLines: null, // Allow multiple lines of text
//               ),
//               SizedBox(height: 40),
//           Row(
//             children: [
//               Expanded(
//                 child: MaterialButton(
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10),),
//                   // style: ElevatedButton.styleFrom(
//                   color: Color.fromRGBO(14,46,92,1),
//                   // shadowColor:Color.fromRGBO(63,190,218,1) ,
//
//                   // borderRadius: BorderRadius.circular(5),// Set the background color here
//                   //   ),
//                   onPressed: () {
//                     // Add your logic here
//                   },
//                   child: Text('Cancel',style: TextStyle(color: Colors.white),),
//                 ),
//               ),
//               SizedBox(width: 3,),
//               Expanded(
//                 child: MaterialButton(
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10),),
//                   // style: ElevatedButton.styleFrom(
//                   color: Color.fromRGBO(14,46,92,1),
//                   // shadowColor:Color.fromRGBO(63,190,218,1) ,
//
//                   // borderRadius: BorderRadius.circular(5),// Set the background color here
//                   //   ),
//                   onPressed: () {
//                     // Add your logic here
//                   },
//                   child: Text('Save',style: TextStyle(color: Colors.white),),
//                 ),
//               ),
//             ],
//           ),
//             ],
//           ),
//         ),
//       );
//
//   }}