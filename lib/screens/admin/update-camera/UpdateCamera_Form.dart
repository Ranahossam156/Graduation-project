import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import '../../../models/CamModel.dart';
import '../../../models/CamRoadModel.dart';
import '../../../shared/remote/api_manager.dart';
import '../../../shared/style/gradient_divider.dart';
import '../../../shared/style/text_field.dart';
import '../add-camera/AddCamera.dart';
import '../admin_home.dart';
import '../drawer_screen.dart';
import '../update_road/latlng.dart';
import 'UpdateCamera.dart';

class UpdateCameraForm extends StatefulWidget {
  static const String routName = "AddCameraForm";
  final CamRoadModel cam;

  UpdateCameraForm({required this.cam});

  @override
  _UpdateCameraFormState createState() => _UpdateCameraFormState();
}

class _UpdateCameraFormState extends State<UpdateCameraForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _modelController;
  late TextEditingController _companyNameController;
  late String address1;
  late LatLng latlng;
  late TextEditingController _dimensionsController;
  late TextEditingController _startdateController;

  bool? _isActive;
  DateTime _startDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    print("${widget.cam.roadCamera!.dimensions!}");
    address1 = extractdescriptionFromAddress(widget.cam.roadCamera!.dimensions!);
    latlng=extractLatLngCameraLocation(widget.cam.roadCamera!.dimensions!);
    _modelController = TextEditingController(text: widget.cam.camera?.model);
    _companyNameController = TextEditingController(text: widget.cam.camera?.factory);
    _dimensionsController = TextEditingController(text: address1);
    _startdateController = TextEditingController(text: widget.cam.roadCamera?.startDate);
   // _enddateController = TextEditingController(text: widget.cam.roadCamera?.endDate);
    _isActive = widget.cam.roadCamera?.active;
  }

  //@override
  // void dispose() {
  //   _modelController.dispose();
  //   _companyNameController.dispose();
  //   _dimensionsController.dispose();
  //   _startdateController.dispose();
  //   _enddateController.dispose();
  //   super.dispose();
  // }

  Future<void> _selectDate(BuildContext context, DateTime startDate, TextEditingController controller) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: startDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.red, // Header background color
            hintColor: Color.fromRGBO(14, 46, 92, 1), // Selection color
            colorScheme: ColorScheme.light(
              primary:  Color.fromRGBO(14, 46, 92, 1), // Header background color and OK button
              onPrimary: Colors.white, // Header text color
              onSurface: Color.fromRGBO(14, 46, 92, 1), // Body text color
            ),
            dialogBackgroundColor: Colors.white, // Background color of the dialog
          ),
          child: child!,
        );
      },
    );
    if (pickedDate != null && pickedDate != startDate) {
      setState(() {
        startDate = pickedDate;
        controller.text = "${startDate.toLocal()}".split(' ')[0]; // Update the text field
      });
    }
  }
  void handleSubmit() async {
    Camera updatedCam ;
      String dimentions='${_dimensionsController.text} ${latlng?.latitude}-${latlng?.longitude}';
      updatedCam = Camera(
        id: widget.cam.camera?.id,
        model: _modelController.text,
        factory: _companyNameController.text,
        startService: _startdateController.text,
        active: _isActive,
        dimentions:dimentions,
          road_id:  widget.cam.roadCamera?.roadId
      );


    try {
      await ApiManager.updateCamera(updatedCam);
    } catch (e) {
      print('Update failed: $e');
    }
   // await ApiManager.updateCamera(updatedCam);
    //await ApiManager.PostCam (camera);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AdminHome()),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Camera updated Successfully')),
    );

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Camera'),
        backgroundColor: Color.fromRGBO(14, 46, 92, 1),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              CustomTextFormField(
                labelText: 'Camera Model',
                validator: (value) {
                  if (value == null || value.isEmpty || value.length < 5 || value.length > 50) {
                    return 'This field is required, min 5 and max 50.';
                  }
                  return null;
                },
                controller: _modelController,
                keyboardType: TextInputType.text,
                textColor: Color.fromRGBO(14, 46, 92, 1),
              ),
              GradientDivider(),
              SizedBox(height: 16),
              CustomTextFormField(
                labelText: 'Company Name',
                validator: (value) {
                  if (value == null || value.isEmpty || value.length < 5 || value.length > 50) {
                    return 'This field is required, min 5 and max 50.';
                  }
                  return null;
                },
                controller: _companyNameController,
                keyboardType: TextInputType.text,
                textColor: Color.fromRGBO(14, 46, 92, 1),
              ),
              GradientDivider(),
              SizedBox(height: 16),
              CustomTextFormField(
                textColor: Color.fromRGBO(14, 46, 92, 1),
                labelText: 'Camera Dimensions',
                validator: (value) {
                  if (value == null || value.isEmpty || value.length < 5 || value.length > 100) {
                    return 'This field is required, min 5 and max 100.';
                  }
                  return null;
                },
                controller: _dimensionsController,
                keyboardType: TextInputType.text,
              ),
              GradientDivider(),
              SizedBox(height: 16),
              Text(
                'Is it active?',
                style: TextStyle(
                  color: Color(0xff076092),
                  fontSize: 18,
                ),
              ),
              RadioListTile<bool>(
                title: Text(
                  'Active',
                  style: TextStyle(
                    color: Color(0xff076092),
                    fontSize: 15,
                  ),
                ),
                value: true,
                activeColor: Color.fromRGBO(14, 46, 92, 1),
                groupValue: _isActive,
                onChanged: (value) {
                  setState(() {
                    _isActive = value;
                  });
                },
              ),
              RadioListTile<bool>(
                title: Text(
                  'Inactive',
                  style: TextStyle(
                    color: Color(0xff076092),
                    fontSize: 15,
                  ),
                ),
                value: false,
                activeColor: Color.fromRGBO(14, 46, 92, 1),
                groupValue: _isActive,
                onChanged: (value) {
                  setState(() {
                    _isActive = value;
                  });
                },
              ),
              SizedBox(height: 16),
              if (_isActive == false)
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.005,
                  ),
                  child: TextFormField(
                    cursorColor: Color(0xff076092),
                    style: const TextStyle(color: Color.fromRGBO(14, 46, 92, 1)),
                    controller: _startdateController,
                    decoration: InputDecoration(
                      labelText: 'Start Date',
                      labelStyle: const TextStyle(
                        color: Color(0xff076092),
                        fontSize: 18,
                      ),
                      contentPadding: const EdgeInsets.only(bottom: 4),
                      border: UnderlineInputBorder(),
                    ),
                    onTap: () async {
                      FocusScope.of(context).requestFocus(new FocusNode()); // To prevent keyboard from appearing
                      await _selectDate(context, _startDate, _startdateController);
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'This field is required';
                      }
                      return null;
                    },
                  ),
                ),
              if (_isActive == false) GradientDivider(),
               SizedBox(height: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(

                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Camera camRoad;
                        String dimentions='${_dimensionsController.text} ${latlng?.latitude}-${latlng?.longitude}';
                          camRoad = Camera(
                              id: widget.cam.camera?.id,
                              model: _modelController.text,
                              factory: _companyNameController.text,
                              startService: _startdateController.text,
                              active: _isActive,
                              dimentions: dimentions,
                              road_id:  widget.cam.roadCamera?.roadId
                          );

                        widget.cam.camera=camRoad;
                      //  print("${widget.cam.roadCamera?.roadId} idddddddddddddd\n${widget.cam.camera?.factory}");
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => UpdateCamera( camera: widget.cam,)),
                        );
                      }
                    },
                    child: Text('Edit Camera Location on Selected Road?', style: TextStyle(color: Color.fromRGBO(14, 46, 92, 1),fontSize: 18, )),
                  ),
                  MaterialButton(

                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Camera camRoad;
                        String dimentions='${_dimensionsController.text} ${latlng?.latitude}-${latlng?.longitude}';
                        camRoad = Camera(
                            id: widget.cam.camera?.id,
                            model: _modelController.text,
                            factory: _companyNameController.text,
                            startService: _startdateController.text,
                            active: _isActive,
                            dimentions: dimentions,
                            road_id:  widget.cam.roadCamera?.roadId
                        );
                        widget.cam.camera=camRoad;
                        //  print("${widget.cam.roadCamera?.roadId} idddddddddddddd\n${widget.cam.camera?.factory}");
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AddCamera(camRoad: camRoad,update: true,)),
                        );
                      }
                    },
                    child: Text('Change Road?', style: TextStyle(color: Color.fromRGBO(14, 46, 92, 1),fontSize: 18, )),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Column(
                children: [
                  MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                   color:Color.fromRGBO(14, 46, 92, 1) ,
                    onPressed: () {
                      handleSubmit();
                    },
                    child: Text('Save', style: TextStyle(color: Colors.white, )),
                  ),
                ],
              ),
            ],
          ),

        ),
      ),
      endDrawer: DrawerScreen(),
    );
  }
}
