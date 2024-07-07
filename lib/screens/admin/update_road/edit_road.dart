import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:graduation_project/screens/admin/admin_home.dart';
import 'package:graduation_project/shared/remote/api_manager.dart';
import 'package:latlong2/latlong.dart';
import '../../../models/RoadModel.dart';
import '../../../shared/style/gradient_divider.dart';
import '../../../shared/style/text_field.dart';
import '../drawer_screen.dart';
import 'editRoad_map.dart';
import 'latlng.dart';

class EditRoad extends HookWidget {
  static const String routeName = "EditRoad";

  final RoadModel road; // RoadModel to edit

  EditRoad({required this.road});

  @override
  Widget build(BuildContext context) {
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final roadNameController = useTextEditingController(text: road.name);
    String address1 = extractdescriptionFromAddress(road.address!);
    final addressController = useTextEditingController(text: address1);

    final loading = useState(false);

    List<LatLng> latLngList = extractLatLngFromAddress(road.address!);

    //print("jjjjjjjjjjj${latLngList[0].longitude}    ${latLngList[1]}");
    final stPoint = useState<LatLng?>(latLngList.isNotEmpty ? latLngList[0] : null);
    final endPoint = useState<LatLng?>(latLngList.length > 1 ? latLngList[1] : null);

    void handleSubmit() async {
      if (formKey.currentState?.validate() ?? false) {
        if (stPoint.value == null || endPoint.value == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Please set a start point and end point on the map')),
          );
          return;
        }

        RoadModel updatedRoad = RoadModel(
          id: road.id,
          name: roadNameController.text,
          address: '${addressController.text} ${stPoint.value!.latitude}-${stPoint.value!.longitude} ${endPoint.value!.latitude}-${endPoint.value!.longitude}',
        );

        loading.value = true;

        try {
          await ApiManager.updateRoad(updatedRoad); // Replace with your update API call
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AdminHome()),
          );
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Road updated successfully')),
          );
        } catch (e) {
          print('Error updating road: $e');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to update road')),
          );
        }

        loading.value = false;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Road'),
        backgroundColor: Color.fromRGBO(14, 46, 92, 1),
      ),
      body: loading.value
          ? Center(child: CircularProgressIndicator())
          : Form(
        key: formKey,
        child: Column(
          children: [

            SizedBox(height: 10,)        ,
            CustomTextFormField(
              textColor:  Color.fromRGBO(14, 46, 92, 1),
              labelText:'Road Name',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the road name';
                }
                return null;
              },
              controller:roadNameController,
              keyboardType: TextInputType.text,

            ),
            GradientDivider(),
            SizedBox(height: 10,)        ,
            CustomTextFormField(
              textColor:  Color.fromRGBO(14, 46, 92, 1),
              labelText:'Address',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the address';
                }
                return null;
              },
              controller:addressController,
              keyboardType: TextInputType.text,

            ),
            GradientDivider(),
            Expanded(
              child: EditRoadMap(
                setSTPoint: (point) => null,
                setENDPoint: (point) => null ,startPoint: stPoint.value,endPoint: endPoint.value,

              ),
            ),
            MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              color: Color.fromRGBO(14, 46, 92, 1),
              onPressed: () {
                handleSubmit();
              },
              child: Text(
                'Save',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
      endDrawer: DrawerScreen(),
    );
  }
}
