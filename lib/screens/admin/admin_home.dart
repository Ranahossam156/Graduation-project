
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/UserModel.dart';
import '../../shared/remote/api_manager.dart';
import '../../shared/style/button.dart';
import 'add-camera/AddCamera.dart';
import 'add-camera/AddCamera_Form.dart';
import 'add_admin/AddAdmin.dart';
import 'add_road/AddRoadPage.dart';
import 'all_users/admin_profile.dart';
import 'drawer_screen.dart';

class AdminHome extends StatelessWidget {
  static const String routName="AdminHome";
  TextEditingController ID = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return
          Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/bg.jpg"), // <-- BACKGROUND IMAGE
              fit: BoxFit.cover,
            ),
          ),
        ),
        Scaffold(
        appBar: AppBar(

        leading: IconButton(
          icon: Icon(Icons.person, color: Colors.white,size: 30),
          onPressed: ()
           async {final SharedPreferences prefs = await SharedPreferences.getInstance();
           var token = prefs.getString('token');
           Result? user = await ApiManager().fetchUserByToken(token!);
             Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AdminProfile(user: user!,)),
          );
             } ,
        ),
       backgroundColor: Color.fromRGBO(14,46,92,1),

      ),
          backgroundColor: Colors.transparent,
           body: Center(
             child: Column(
               children: [
                 SizedBox(height: 90,),
    // Center(
    //   child: Container(
    //     width: 135, // Adjust width to make the button larger
    //     height: 145,
    //   decoration: BoxDecoration(
    //   image: DecorationImage(
    //   image: AssetImage("assets/images/profile.png"), // <-- BACKGROUND IMAGE
    //   fit: BoxFit.cover,
    //   ),
    //   ),
    //   ),
    // ),

                          SizedBox(height: 100,),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddRoadPage()),
                    );
                  },
                  child: CustomButton(
                    label: 'Add Road',
                    imagePath: 'assets/images/button1.png',
                    c: Colors.black,
                    icon: Icons.add_road, // Specify the icon here
                  ),

    ),

                    // SizedBox(height: 42,)
                    // ,
                    // InkWell(
                    //   onTap: () {
                    //     //////////////
                    //     Navigator.push(
                    //       context,
                    //       MaterialPageRoute(builder: (context) => EditCamera()),
                    //     );
                    //   },
                    //   child: CustomButton(label: 'Update Camera', image_path: 'assets/images/button2.png', c: Colors.white,),
                    // )
                    // ,
                    SizedBox(height: 45,)
                    ,
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => CameraForm()),
                        );
                      },
                      child: CustomButton(
                        label: 'Add Camera',
                        imagePath: 'assets/images/button1.png',
                        c: Colors.black,
                        icon: Icons.add_a_photo_sharp, // Specify the icon here
                      ),

                    )
                    ,
                 SizedBox(height: 45,)
                 ,
                 InkWell(
                   onTap: () { Navigator.push(
                     context,
                     MaterialPageRoute(builder: (context) => AddAdmin()),
                   );    } ,
                   child: CustomButton(
                     label: 'Add Admin',
                     imagePath: 'assets/images/button1.png',
                     c: Colors.black,
                     icon: Icons.person_add_alt_sharp, // Specify the icon here
                   ),

                 )
                 ,
                    // SizedBox(height: 42,),
                    // InkWell(
                    //   onTap: () {
                    //     //////////////
                    //     Navigator.push(
                    //       context,
                    //       MaterialPageRoute(builder: (context) => ShowRoad()),
                    //     );
                    //   },
                    //   child: CustomButton(label: 'Update Road', image_path: 'assets/images/button2.png', c: Colors.white,),
                    // )

                  ],
                ),
    ),
          endDrawer: DrawerScreen(),)]

          );
  }
  String? validator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter some text';
    }
    // You can add more validation rules here if needed
    return null; // Return null if the input is valid
  }


// void onDrawerSelected(indx){
//   // if(indx==DrawerScreen.CATEGORIES){
//   // //  categoryData=null;
//   // }
//   // else if(indx==DrawerScreen.SETTINGS){
//   //   //open settings screen
//   // }
//
// }
}

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// import 'package:graduation_project/shared/style/button.dart';
//
// import 'add-camera/AddCamera.dart';
// import 'add_road/AddRoadPage.dart';
// import 'get_camera/get_camera.dart';
//
//
//
// class  AdminHome extends StatelessWidget {
//   static const String routName="AdminHome";
//   const AdminHome ({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return  Stack(
//       children: [
//         Container(
//           decoration: BoxDecoration(
//             image: DecorationImage(
//               image: AssetImage("assets/images/bg.jpg"), // <-- BACKGROUND IMAGE
//               fit: BoxFit.cover,
//             ),
//           ),
//         ),
//         Scaffold(
//           backgroundColor: Colors.transparent,
//            body: Center(
//              child: Column(
//                children: [
//                  SizedBox(height: 90,),
//     Center(
//       child: Container(
//         width: 135, // Adjust width to make the button larger
//         height: 145,
//       decoration: BoxDecoration(
//       image: DecorationImage(
//       image: AssetImage("assets/images/profile.png"), // <-- BACKGROUND IMAGE
//       fit: BoxFit.cover,
//       ),
//       ),
//       ),
//     ),
//
//                  SizedBox(height: 50,),
//                 InkWell(
//
//                   onTap: () {
//                   //////
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => AddCamera()),
//                     );
//                   },
//                   child: CustomButton(label: 'Add Camera', imagePath: 'assets/images/button1.png', c: Colors.black,),
//                 )
//                  ,
// SizedBox(height: 42,)
// ,
//  InkWell(
//     onTap: () {
//   //////////////
//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => EditCamera()),
//       );
//     },
//     child: CustomButton(label: 'Update Camera', imagePath: 'assets/images/button1.png', c: Colors.black,),
//     )
// ,
//                  SizedBox(height: 42,)
//                  ,
//                  InkWell(
//                    onTap: () {
//                      //////////////
//                      Navigator.push(
//                        context,
//                        MaterialPageRoute(builder: (context) => AddRoadPage()),
//                      );
//                    },
//                    child: CustomButton(label: 'Add Road', imagePath: 'assets/images/button1.png', c: Colors.black,),
//                  ),
//
//     SizedBox(height: 42,),
//                  InkWell(
//                    onTap: () {
//                      //////////////
//                      Navigator.push(
//                        context,
//                        MaterialPageRoute(builder: (context) => EditRoad()),
//                      );
//                    },
//                    child: CustomButton(label: 'Update Road', imagePath: 'assets/images/button1.png', c: Colors.black,),
//                  )
//
//     ],
//              ),
//            )
//         ),
//       ],
//     );
//   }
// }










//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import '../../shared/style/button.dart';
// import 'add-camera/AddCamera.dart';
// import 'add-camera/AddCamera_Form.dart';
// import 'add_admin/AddAdmin.dart';
// import 'add_road/AddRoadPage.dart';
// import 'drawer_screen.dart';
//
// class AdminHome extends StatelessWidget {
//   static const String routName="AdminHome";
//   TextEditingController ID = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//
//         leading: IconButton(
//           icon: Icon(Icons.person_add_alt_1_sharp, color: Colors.white,size: 30),
//           onPressed: () { Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => AddAdmin()),
//           );    } ,
//         ),
//        backgroundColor: Color.fromRGBO(14,46,92,1),
//
//       ),
//
//       body: SingleChildScrollView(
//         child: Column(
//            crossAxisAlignment:CrossAxisAlignment.stretch,
//             children: [
//               Stack(
//                 children: [
//                   Container(
//                       height: 280,
//
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                        // borderRadius: BorderRadius.only(bottomRight: Radius.circular(20),bottomLeft: Radius.circular(20)), // Adjust the value as needed
//                       )
//                   ),
//                   Center(
//                     child: Padding(
//                       padding: const EdgeInsets.all(70),
//                       child: Image.asset(
//                         'assets/images/profile.png', // Add your image path here
//                         width: 180,
//                         height: 180,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//
//               Container(
//                  height: 500,
//                 decoration: BoxDecoration(
//                   color: Color.fromRGBO(14,46,92,1),
//                   borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20)), // Adjust the value as needed
//                 ),
//                 child: Column(
//                   //crossAxisAlignment: CrossAxisAlignment.stretch,
//                   children: [
//                     SizedBox(height: 100,),
//                 InkWell(
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => AddRoadPage()),
//                     );
//                   },
//                   child: CustomButton(
//                     label: 'Add Road',
//                     imagePath: 'assets/images/button1.png',
//                     c: Colors.black,
//                     icon: Icons.add_road, // Specify the icon here
//                   ),
//
//     ),
//
//                     // SizedBox(height: 42,)
//                     // ,
//                     // InkWell(
//                     //   onTap: () {
//                     //     //////////////
//                     //     Navigator.push(
//                     //       context,
//                     //       MaterialPageRoute(builder: (context) => EditCamera()),
//                     //     );
//                     //   },
//                     //   child: CustomButton(label: 'Update Camera', image_path: 'assets/images/button2.png', c: Colors.white,),
//                     // )
//                     // ,
//                     SizedBox(height: 45,)
//                     ,
//                     InkWell(
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(builder: (context) => CameraForm()),
//                         );
//                       },
//                       child: CustomButton(
//                         label: 'Add Camera',
//                         imagePath: 'assets/images/button1.png',
//                         c: Colors.black,
//                         icon: Icons.add_a_photo_sharp, // Specify the icon here
//                       ),
//
//                     )
//                     ,
//                     // SizedBox(height: 42,),
//                     // InkWell(
//                     //   onTap: () {
//                     //     //////////////
//                     //     Navigator.push(
//                     //       context,
//                     //       MaterialPageRoute(builder: (context) => ShowRoad()),
//                     //     );
//                     //   },
//                     //   child: CustomButton(label: 'Update Road', image_path: 'assets/images/button2.png', c: Colors.white,),
//                     // )
//
//                   ],
//                 ),
//               ),
//             ]),
//       ),
//       endDrawer: DrawerScreen(),
//     );
//
//   }
//   String? validator(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Please enter some text';
//     }
//     // You can add more validation rules here if needed
//     return null; // Return null if the input is valid
//   }
//
//
//   // void onDrawerSelected(indx){
//   //   // if(indx==DrawerScreen.CATEGORIES){
//   //   // //  categoryData=null;
//   //   // }
//   //   // else if(indx==DrawerScreen.SETTINGS){
//   //   //   //open settings screen
//   //   // }
//   //
//   // }
// }
