import 'package:flutter/material.dart';
import 'package:graduation_project/screens/user%20features/setting/change_password_screen.dart';
import 'package:graduation_project/screens/user%20features/setting/edit_profile_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../models/UserModel.dart';
import '../../../shared/constant/constants.dart';
import '../../../shared/remote/api_manager.dart';
import '../../admin/all_users/UserDetailsScreen.dart';
import '../get_history_user/GetHistoryUser.dart';


class MenuIconList extends StatelessWidget {
  const MenuIconList({super.key});

  @override
  Widget build(BuildContext context) {

    return PopupMenuButton(
      icon: const Icon(Icons.menu,color:Colors.white,size:30), // Use the menu icon here
      onSelected: (value) async {
        if (value == "Edit profile") {
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          var token = prefs.getString('token');
          print('Retrieved Token: $token'); // Print the token to check its value
          Result? user = await ApiManager().fetchUserByToken(token!);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditProfileScreen(user:user!),
            ),
          );
        }
        else if (value == "Change password") {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChangePasswordScreen(),
            ),
          );
        }
        else if (value == "Profile") {
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          var token = prefs.getString('token');
          Result? user = await ApiManager().fetchUserByToken(token!);
          // Result? user=ApiManager().fetchUserByToken( token!) as Result?;
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => UserDetailsScreen(user: user!)),
          );
        }
        else if (value == "History") {

            final SharedPreferences prefs = await SharedPreferences.getInstance();
            var token = prefs.getString('token');
            Result? user = await ApiManager().fetchUserByToken(token!);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HistoryUserPage(user!)),
            );
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry>[
        const PopupMenuItem(
          value: "Profile",
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: Icon(Icons.person,color: Constants.primaryColor,),
              ),
              Text(
                'Profile',
                style: TextStyle(fontSize: 15,color:Constants.primaryColor),
              ),
            ],
          ),
        ),
        const PopupMenuItem(
          value: "Edit profile",
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: Icon(Icons.edit,color: Constants.primaryColor,),
              ),
              Text(
                'Edit profile',
                style: TextStyle(fontSize: 15,color:Constants.primaryColor),
              ),
            ],
          ),
        ),
        const PopupMenuItem(
          value: "Change password",
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: Icon(Icons.password,color: Constants.primaryColor,),
              ),
              Text(
                'Change password',
                style: TextStyle(fontSize: 15,color:Constants.primaryColor),
              ),
            ],
          ),
        ),
        PopupMenuItem(
          value: "History",
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: Icon(Icons.history_sharp,color: Constants.primaryColor,),
              ),
              Text(
                'History',
                style: TextStyle(fontSize: 15,color:Constants.primaryColor),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
