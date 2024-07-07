// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import '../../../models/CamModel.dart';
//
// class CameraForm extends StatefulWidget {
//   static const String routName="AddCamera";
//   @override
//   _CameraFormState createState() => _CameraFormState();
// }
//
// class _CameraFormState extends State<CameraForm> {
//   final _formKey = GlobalKey<FormState>();
//   final _modelController = TextEditingController();
//   final _companyNameController = TextEditingController();
//   final _dimensionsController = TextEditingController();
//   bool? _isActive;
//   String? _selectedRoad;
//   String? _startDate;
//
//   @override
//   Widget build(BuildContext context) {
//   //  final cameraProvider = Provider.of<CameraProvider>(context);
//
//     return Scaffold(
//       appBar: AppBar(title: Text('Add New Camera'),
//       backgroundColor:  Color.fromRGBO(14,46,92,1),
//       ),
//
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: ListView(
//             children: [
//               TextFormField(
//                 controller: _modelController,
//                 decoration: InputDecoration(labelText: 'Camera Model'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty || value.length < 5 || value.length > 50) {
//                     return 'This field is required, min 5 and max 50.';
//                   }
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 controller: _companyNameController,
//                 decoration: InputDecoration(labelText: 'Company Name'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty || value.length < 5 || value.length > 50) {
//                     return 'This field is required, min 5 and max 50.';
//                   }
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 controller: _dimensionsController,
//                 decoration: InputDecoration(labelText: 'Camera Dimensions'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty || value.length < 5 || value.length > 50) {
//                     return 'This field is required, min 5 and max 50.';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 16),
//               Text('Is it active?'),
//               RadioListTile<bool>(
//                 title: Text('True'),
//                 value: true,
//                 groupValue: _isActive,
//                 onChanged: (value) {
//                   setState(() {
//                     _isActive = value;
//                   });
//                 },
//               ),
//               RadioListTile<bool>(
//                 title: Text('False'),
//                 value: false,
//                // tileColor:  Color.fromRGBO(14,46,92,1),
//
//                 groupValue: _isActive,
//                 onChanged: (value) {
//                   setState(() {
//                     _isActive = value;
//                   });
//                 },
//               ),
//               if (_isActive == false)
//                 TextFormField(
//                   decoration: InputDecoration(labelText: 'Start Date'),
//                   onTap: () async {
//                     FocusScope.of(context).requestFocus(FocusNode());
//                     DateTime? pickedDate = await showDatePicker(
//                       context: context,
//                       initialDate: DateTime.now(),
//                       firstDate: DateTime(2000),
//                       lastDate: DateTime(2101),
//                     );
//                     if (pickedDate != null) {
//                       setState(() {
//                         _startDate = "${pickedDate.toLocal()}".split(' ')[0];
//                       });
//                     }
//                   },
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'This field is required';
//                     }
//                     return null;
//                   },
//                 ),
//               // DropdownButtonFormField<String>(
//               //   decoration: InputDecoration(labelText: 'Unique Road'),
//               //   value: _selectedRoad,
//               //   // items: cameraProvider.roads.map((String road) {
//               //   //   return DropdownMenuItem<String>(
//               //   //     value: road,
//               //   //     child: Text(road),
//               //   //   );
//               //   // }).toList(),
//               //   onChanged: (newValue) {
//               //     setState(() {
//               //       _selectedRoad = newValue;
//               //     });
//               //   },
//               //   validator: (value) {
//               //     if (value == null || value.isEmpty) {
//               //       return 'This field is required';
//               //     }
//               //     return null;
//               //   },
//               // ),
//               SizedBox(height: 16),
//               // ElevatedButton(
//               //   onPressed: () {
//               //     if (_formKey.currentState!.validate()) {
//               //       Camera newCamera = Camera(
//               //         model: _modelController.text,
//               //         companyName: _companyNameController.text,
//               //         dimensions: _dimensionsController.text,
//               //         isActive: _isActive,
//               //         startDate: _startDate,
//               //         roadId: _selectedRoad,
//               //       );
//               //      // cameraProvider.updateCamera(newCamera);
//               //       Navigator.push(
//               //         context,
//               //         MaterialPageRoute(builder: (context) => CameraMap()),
//               //       );
//               //     }
//               //   },
//               //   child: Text('Add New Camera'),
//               // ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
