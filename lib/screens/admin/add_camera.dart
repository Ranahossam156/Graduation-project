import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddCamera extends StatelessWidget {
  static const String routName="AddCamera";
  TextEditingController ID = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Color.fromRGBO(14,46,92,1),
      ),
      body: SingleChildScrollView(
        child: Column(
         // mainAxisAlignment: MainAxisAlignment.start,
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
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
          //    controller:idController ,
                      textInputAction: TextInputAction.next,
                  keyboardType:TextInputType.number,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.camera_alt,color: Color.fromRGBO(14,46,92,1)),
           //   decoration: InputDecoration(
                labelText: 'Enter CameraID',

              ),
              maxLines: null, // Allow multiple lines of text
            ),
            SizedBox(height: 20),
            TextField(
              textInputAction: TextInputAction.next,

           //   controller:idController ,
              decoration: InputDecoration(
                labelText: 'Enter Location',
                prefixIcon: Icon(Icons.location_on,color: Color.fromRGBO(14,46,92,1)),
              ),
              maxLines: null, // Allow multiple lines of text
            ),
            SizedBox(height: 50),
            MaterialButton(
              //padding: EdgeInsets.only(left: 50,right: 50),

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),),
              // style: ElevatedButton.styleFrom(
              color: Color.fromRGBO(14,46,92,1),
              // shadowColor:Color.fromRGBO(63,190,218,1) ,

              // borderRadius: BorderRadius.circular(5),// Set the background color here
              //   ),
              onPressed: () {
                // Add your logic here
              },
              child: Text('Add',style: TextStyle(color: Colors.white),),
            ),
          ],
        ),
      ),
        ]),
      ),
    );

  }
  String? validator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter some text';
    }
    // You can add more validation rules here if needed
    return null; // Return null if the input is valid
  }

}
