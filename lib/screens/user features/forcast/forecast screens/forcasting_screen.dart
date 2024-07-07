import 'package:flutter/material.dart';
import 'package:graduation_project/screens/admin/all_users/UserDetailsScreen.dart';
import 'package:graduation_project/screens/user%20features/forcast/forecast%20screens/map4.dart';
import 'package:graduation_project/shared/remote/api_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../models/UserModel.dart';
import '../../../../shared/constant/constants.dart';
import '../../user widgets/menu_icon_list.dart';
import '../forecast widgets/bottom_sheet_widget.dart';

class ForecastingScreen extends StatefulWidget {
  static const String routName = "forecasting";

  const ForecastingScreen({Key? key}) : super(key: key);

  @override
  State<ForecastingScreen> createState() => _ForecastingScreenState();
}

class _ForecastingScreenState extends State<ForecastingScreen> {
  String _pickedLocation = '';
  final addressController = TextEditingController();
  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(14,46,92,1),
          title: const Center(
            child: Text(
              'Traffic Detector',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
          actions: <Widget>[
                      MenuIconList()
            
          ],
             leading: IconButton(
            icon: Icon(Icons.person, color: Colors.white,size: 30),
        onPressed: ()
        async {
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          var token = prefs.getString('token');
          Result? user = await ApiManager().fetchUserByToken(token!);
         // Result? user=ApiManager().fetchUserByToken( token!) as Result?;
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => UserDetailsScreen(user: user!)),
          );
        } ,
      ),
        ),
        body: Column(
          children: [
            Expanded(
              child: Map4(), // Replace with your map widget (Map4)
            ),
      MaterialButton(
        minWidth: 80,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        color: Constants.primaryColor,
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) => BottomSheetWidget(),
          );
        },
        child: const Text(
          'Start Forcasting',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
          ],
        ),
      ),
    );
  }
}
