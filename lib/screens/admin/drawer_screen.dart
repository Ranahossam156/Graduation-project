import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/screens/admin/admin_home.dart';
import 'package:graduation_project/screens/admin/get-roads/get_road.dart';
import 'package:graduation_project/screens/admin/get_camera/get_camera.dart';
import 'package:graduation_project/screens/admin/get_plans/get_plans.dart';


import 'all_users/AllAdmins.dart';
import 'all_users/AllUsers.dart';
import 'get_history_admin/GetHistory.dart';
import 'get_subscriptions/GetSubscriotions.dart';


class DrawerScreen extends StatelessWidget {
  DrawerScreen();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        width: 10,
        height: 10,
        color: Colors.transparent,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromRGBO(14,46,92,1),
              ),
              child: Center(
                child: Image.asset(
                  'assets/images/logo.png', // Add your image path here
                  width: 120,
                  height: 120,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                // Handle the tap here.
                Navigator.push(
                    context,
                MaterialPageRoute(builder: (context) => AdminHome()));
                //Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.person_2_sharp),
              title: Text('Admins'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AdminListScreen ()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.contacts),
              title: Text('Users'),
              onTap: () {
                // Handle the tap here.UserListScreen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserListScreen ()),
                );

              },
            ),
            ListTile(
              leading: Icon(Icons.camera_enhance_sharp),
              title: Text('Cameras'),
              onTap: () {
                //////////////
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EditCamera()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.edit_road_sharp),
              title: Text('Roads'),
              onTap: () {
                //////////////
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ShowRoad()),
                );
              },
            ),


            //SubscriptionsPage

            ListTile(
              leading: Icon(Icons.history),
              title: Text('Forcast History'),
              onTap: () {
                //////////////
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HistoryPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.subscriptions_outlined),
              title: Text('Subscribers'),
              onTap: () {
                //////////////
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SubscribtionsPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.assignment_sharp),
              title: Text('Subscription Plans'),
              onTap: () {
                //////////////
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GetPlan(isUser: false,)),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
