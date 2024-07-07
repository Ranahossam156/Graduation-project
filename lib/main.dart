import 'package:flutter/material.dart';
import 'package:graduation_project/screens/Authentication/Authentication%20screens/login_screen.dart';
import 'package:graduation_project/screens/admin/add-camera/AddCamera_Form.dart';
import 'package:graduation_project/screens/admin/add_road/AddRoadPage.dart';
import 'package:graduation_project/screens/admin/admin_home.dart';
import 'package:graduation_project/screens/admin/get-roads/get_road.dart';
import 'package:graduation_project/screens/admin/get_camera/get_camera.dart';
import 'package:graduation_project/screens/Authentication/spalsh_screen.dart';
import 'package:graduation_project/screens/user%20features/forcast/forecast%20screens/forcasting_screen.dart';
import 'package:graduation_project/screens/user%20features/premium/page1.dart';
import 'cache/cache_helper.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  CacheHelper().init();
  runApp( const MyApp());

}

class MyApp extends StatelessWidget {
   const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return
  MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute:  SplashScreen.routName,
      routes: {
        SplashScreen.routName:(context) => SplashScreen(),
        LoginScreen.routeName:(context) =>LoginScreen(),
        ForecastingScreen.routName:(context) => ForecastingScreen(),
        AdminHome.routName:(context) => AdminHome(),
        EditCamera.routName:(context)=>EditCamera(),
        ShowRoad.routName:(context)=>ShowRoad(),
        CameraForm.routName: (context) =>CameraForm(),
        AddRoadPage.routName:(context) => AddRoadPage(),
        Page1_Premium.routName:(context)=>Page1_Premium(),
      },
    );
  }
}

