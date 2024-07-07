import 'package:flutter/material.dart';
import 'package:graduation_project/models/ForcastingDataModel.dart';
import 'package:graduation_project/screens/user%20features/forcast/forecast%20screens/show_result.dart';
import 'package:graduation_project/screens/user%20features/forcast/forecast%20widgets/time_picker_textField.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../models/UserModel.dart';
import '../../../../shared/constant/constant.dart';
import '../../../../shared/constant/constants.dart';
import '../../../../shared/remote/api_manager.dart';
import 'DropdownList.dart';
import 'date_picker_text_field.dart';


class ForecastButton extends StatelessWidget {
  const ForecastButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return //UnconstrainedBox(
       Padding(
         padding: const EdgeInsets.only(left:80 , right: 80),
         child: ElevatedButton(
           onPressed: () async {
             final SharedPreferences prefs = await SharedPreferences.getInstance();
             var token = prefs.getString('token');
             Result? user = await ApiManager().fetchUserByToken(token!);
             DateTime referenceDate = DateTime(2017, 6, 30);
             Duration difference = selectedDate!.difference(referenceDate);
             bool isBefore = selectedDate!.isBefore(referenceDate);
             int daysDifference = difference.inDays;
                String date=formatDate(selectedDate!);
                String time =formatTime(selectedDateTime!);
             RoadData road=RoadData(roadId: roadId, date: date, time: time);
             print("${road.roadId}       ${road.date}           ${road.time}");
                 if(isBefore==true){

                   ScaffoldMessenger.of(context).showSnackBar(
                     const SnackBar(content: Text('Forcasting only for Upcoming days')),
                   );
                 }

             else if(user?.isPremium==true||daysDifference<=7)
               {
                 Navigator.push(
                   context,
                   MaterialPageRoute(builder: (context) =>  ShowForecastingResultScreen(roadData: road,)),
                 );
               }
             else
               {
                 Navigator.push(
                   context,
                   MaterialPageRoute(builder: (context) =>  ShowForecastingResultScreen(roadData: road,)),
                 );
               }
           },
           style: ElevatedButton.styleFrom(
             backgroundColor: Constants.primaryColor,
             textStyle: const TextStyle(color: Colors.black),
             shape:
             RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
           ),
           child: const Text(
             'Forecast',
             style: TextStyle(
               color: Colors.white,
               fontSize: 16,
               fontWeight: FontWeight.w500,
             ),
           ),
         ),
       );
  }
}
