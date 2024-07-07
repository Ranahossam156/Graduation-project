import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import '../../../models/CamModel.dart';
import '../../../models/CamRoadModel.dart';
import '../../../models/PlanModel.dart';
import '../../../shared/remote/api_manager.dart';
import '../../../shared/style/gradient_divider.dart';
import '../../../shared/style/text_field.dart';
import '../add-camera/AddCamera.dart';
import '../admin_home.dart';
import '../drawer_screen.dart';
import '../update_road/latlng.dart';


class UpdatePlan extends StatefulWidget {
  static const String routName = "UpdatePlan";
  Plans plan ;

  UpdatePlan   (this.plan,{super.key});

 // UpdateCameraForm({required this.cam});

  @override
  _UpdateCameraFormState createState() => _UpdateCameraFormState();
}

class _UpdateCameraFormState extends State<UpdatePlan> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController NameController;
  late TextEditingController DescriptionController;
  late TextEditingController PriceController;
  late TextEditingController DurationController;
  late TextEditingController DiscountController;
  bool? _isActive;
  DateTime _startDate = DateTime.now();

  @override
  void initState() {

    super.initState();
    print("${widget.plan.name}");
    //address1 = extractdescriptionFromAddress(widget.cam.roadCamera!.dimensions!);
   // latlng=extractLatLngCameraLocation(widget.cam.roadCamera!.dimensions!);
    NameController = TextEditingController(text: widget.plan.name);
    DescriptionController= TextEditingController(text: widget.plan.description);
    PriceController = TextEditingController(text: widget.plan.price.toString());
    DurationController = TextEditingController(text: widget.plan.periodInDays.toString());
    // _enddateController = TextEditingController(text: widget.cam.roadCamera?.endDate);
    DiscountController = TextEditingController(text: widget.plan.discount.toString());

  }

  //////discount
  void handleSubmit() async {
    Plans updatedPlan ;
    updatedPlan = Plans(
        id: widget.plan.id,
        name: NameController.text,
        description: DescriptionController.text,
        discount: DiscountController.text,
        periodInDays: int.parse(DurationController.text),
        price:int.parse(PriceController.text),

    );


    try {
      await ApiManager().updatePlan(updatedPlan);
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
      SnackBar(content: Text('Plan updated Successfully')),
    );

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Plan'),
        backgroundColor: Color.fromRGBO(14, 46, 92, 1),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                CustomTextFormField(
                  labelText: 'Plan Name',
                  validator: (value) {
                    if (value == null || value.isEmpty ) {
                      return 'This field is required.';
                    }
                    return null;
                  },
                  controller: NameController,
                  keyboardType: TextInputType.text,
                  textColor: Color.fromRGBO(14, 46, 92, 1),
                ),
                GradientDivider(),
                SizedBox(height: 16),
                CustomTextFormField(
                  labelText: 'Description',
                  validator: (value) {
                    if (value == null || value.isEmpty ) {
                      return 'This field is required.';
                    }
                    return null;
                  },
                  controller: DescriptionController,
                  keyboardType: TextInputType.text,
                  textColor: Color.fromRGBO(14, 46, 92, 1),
                ),
                GradientDivider(),
                SizedBox(height: 16),
                CustomTextFormField(
                  textColor: Color.fromRGBO(14, 46, 92, 1),
                  labelText: 'Price',
                  validator: (value) {
                    if (value == null || value.isEmpty ) {
                      return 'This field is required.';
                    }
                    return null;
                  },
                  controller: PriceController,
                  keyboardType: TextInputType.text,
                ),
                GradientDivider(),
                SizedBox(height: 16),


                CustomTextFormField(
                  textColor: Color.fromRGBO(14, 46, 92, 1),
                  labelText: 'Subscription Duration',
                  validator: (value) {
                    if (value == null || value.isEmpty ) {
                      return 'This field is required.';
                    }
                    return null;
                  },
                  controller: DurationController,
                  keyboardType: TextInputType.text,
                ),

                GradientDivider(),
                SizedBox(height: 16),

                CustomTextFormField(
                  textColor: Color.fromRGBO(14, 46, 92, 1),
                  labelText: 'Discount',
                  validator: (value) {
                    if (value == null || value.isEmpty ) {
                      return 'This field is required.';
                    }
                    return null;
                  },
                  controller: DiscountController,
                  keyboardType: TextInputType.text,
                ),

                GradientDivider(),
                SizedBox(height: 16),


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
      ),
      endDrawer: DrawerScreen(),
    );
  }
}
