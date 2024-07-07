import 'package:flutter/material.dart';
import '../../../models/CamModel.dart';
import '../../../shared/style/gradient_divider.dart';
import '../../../shared/style/text_field.dart';
import '../drawer_screen.dart';
import 'AddCamera.dart';

class CameraForm extends StatefulWidget {
  static const String routName = "AddCameraForm";

  @override
  _CameraFormState createState() => _CameraFormState();
}

class _CameraFormState extends State<CameraForm> {
  final _formKey = GlobalKey<FormState>();
  final _modelController = TextEditingController();
  final _companyNameController = TextEditingController();
  final _dimensionsController = TextEditingController();
  TextEditingController _startdateController = TextEditingController();
  TextEditingController _enddateController = TextEditingController();
  bool? _isActive;

  DateTime _startDate = DateTime.now();
 DateTime _endDate=DateTime.now();
  Future<void> _selectDate(BuildContext context,DateTime startDate,TextEditingController _Controller) async {
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
        _Controller.text = "${startDate!.toLocal()}".split(' ')[0]; // Update the text field
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Camera'),
        backgroundColor: Color.fromRGBO(14, 46, 92, 1),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [

              CustomTextFormField(
                labelText:'Camera Model',
                validator: (value) {
                  if (value == null || value.isEmpty || value.length < 5 || value.length > 50) {
                    return 'This field is required, min 5 and max 50.';
                  }
                  return null;
                },
                controller:  _modelController,
                keyboardType: TextInputType.text,
                textColor:  Color.fromRGBO(14, 46, 92, 1),
              ),
              GradientDivider(),
              SizedBox(height: 16),
              CustomTextFormField(
                labelText:'Company Name',
                validator: (value) {
                  if (value == null || value.isEmpty || value.length < 5 || value.length > 50) {
                    return 'This field is required, min 5 and max 50.';
                  }
                  return null;
                },
                controller: _companyNameController,
                keyboardType: TextInputType.text,
                textColor:  Color.fromRGBO(14, 46, 92, 1),
              ),
              GradientDivider(),
              SizedBox(height: 16),
              CustomTextFormField(
                textColor:  Color.fromRGBO(14, 46, 92, 1),
                labelText:'Camera Dimensions',
                validator: (value) {
                  if (value == null || value.isEmpty || value.length < 5 || value.length > 50) {
                    return 'This field is required, min 5 and max 50.';
                  }
                  return null;
                },
                controller:_dimensionsController,
                keyboardType: TextInputType.text,

              ),
              GradientDivider(),
              SizedBox(height: 16),
              Text('Is it active?',style: TextStyle(
                  color: Color(0xff076092),
          fontSize: 18,

        )),
              RadioListTile<bool>(
                title: Text('Active',style: TextStyle(
                  color: Color(0xff076092),
                  fontSize: 15,

                )),
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

                title: Text('Inactive',style: TextStyle(
                  color: Color(0xff076092),
                  fontSize: 15,)),
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
                    style:const TextStyle(color:  Color.fromRGBO(14, 46, 92, 1)) ,
                    controller: _startdateController,
                    decoration: InputDecoration(
                      labelText: 'Start Date',
                      labelStyle: const TextStyle(
                        color: Color(0xff076092),
                        fontSize: 18,

                      ),
                      contentPadding: const EdgeInsets.only(bottom: 4),
                      border:UnderlineInputBorder(),

                    ),
                    onTap: () async {
                      FocusScope.of(context).requestFocus(new FocusNode()); // To prevent keyboard from appearing
                      await _selectDate(context,_startDate,_startdateController);
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'This field is required';
                      }
                      return null;
                    },
                  ),
                ),
              if (_isActive == false)
              GradientDivider(),
              if (_isActive == false)
              SizedBox(height: 16),

              Column(
                children: [
                  MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    color: Color.fromRGBO(14, 46, 92, 1),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Camera camRoad;
                        if (_isActive == true)
                        camRoad = Camera(
                          model: _modelController.text,
                          factory: _companyNameController.text,
                          active: _isActive,
                          startService: "${_startDate!.toLocal()}".split(' ')[0],
                         dimentions: _dimensionsController.text,
                        );
                      else
                          camRoad = Camera(
                            model: _modelController.text,
                            factory: _companyNameController.text,
                            startService: _startdateController.text,
                            active: _isActive,
                            dimentions: _dimensionsController.text,
                          );
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AddCamera(camRoad: camRoad,update: false,)),
                        );
                      }
                    },
                    child: Text('Select Road', style: TextStyle(color: Colors.white)),
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
