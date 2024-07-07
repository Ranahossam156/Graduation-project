import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/models/PlanModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../shared/remote/api_manager.dart';
import 'PaymentWebView.dart';


class PlanUserItem extends StatelessWidget {

  Plans plan ;
  PlanUserItem (this.plan,{super.key});


  @override
  Widget build(BuildContext context) {
    return          MaterialButton(
      onPressed: () async {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        var token = prefs.getString('token');
      try {
        String url=await ApiManager().Subscripe(token!,plan.price!,plan.id!);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PaymentWebView(paymentUrl: url),
          ),
        );
      } catch (e) {

         print( 'Error: ${e.toString()}' );

      }
      },
      child: Card(

        elevation:0,
        color: Colors.white,
        child: Container(
          height: 50,
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(border: Border.all(color: Colors.black,width: 2)
            ,
            borderRadius: BorderRadius.circular(18),),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("${plan.periodInDays} Days",style: TextStyle(fontWeight: FontWeight.w500)),
              Text('${plan.price} EGP',style: TextStyle(fontWeight: FontWeight.w500)),
            ],
          ),
        ),
      ),
    );
  }
}
