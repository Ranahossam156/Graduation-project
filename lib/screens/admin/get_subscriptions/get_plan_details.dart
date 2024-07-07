import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:graduation_project/screens/admin/admin_home.dart';
import 'package:graduation_project/shared/remote/api_manager.dart';
import 'package:provider/provider.dart';
import 'package:latlong2/latlong.dart';
import '../../../models/PlanModel.dart';
import '../../../models/RoadModel.dart';
import '../../../models/UserModel.dart';
import '../../../shared/style/detailsItem.dart';
import '../../../shared/style/gradient_divider.dart';
import '../../../shared/style/text_field.dart';
import '../drawer_screen.dart';


class PlanDetails extends HookWidget {
  final Plans plan;

  PlanDetails({required this.plan});
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
          title: Text('(${plan.name}) Subscription Plan ',),
          backgroundColor: Color.fromRGBO(14,46,92,1)
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                    height: 300,

                    decoration: BoxDecoration(
                      color: Color.fromRGBO(14,46,92,1),
                      borderRadius: BorderRadius.only(bottomRight: Radius.circular(20),bottomLeft: Radius.circular(20)), // Adjust the value as needed
                    )
                ),
                Center(
                  child: Image.asset(
                    'assets/images/logo.png', // Add your image path here
                    width: 280,
                    height: 280,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildDetailItem(  label: 'ID', value: plan.id,),
                  buildDetailItem(  label: 'Name', value: plan.name,),
                  buildDetailItem(  label: 'Description', value: plan.description,),
                 // buildDetailItem(  label: 'Type', value: plan.type,),
                  buildDetailItem(  label: 'Price', value: '${plan.price} EGP',),
                  buildDetailItem(  label: 'Discount', value: '${plan.discount} %',),
                  buildDetailItem(  label: 'Duration ', value: '${plan.periodInDays} Days',),

                ],
              ),
            ),
          ],
        ),
      ),
      endDrawer: DrawerScreen(),
    );
  }
}
