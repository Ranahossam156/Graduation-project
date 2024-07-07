import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/models/RoadModel.dart';


import '../../../models/CamModel.dart';
import '../../../shared/remote/api_manager.dart';
import 'camera_item.dart';

class EditCamera extends StatelessWidget {
  static const String routName="EditCamera";
  const EditCamera({super.key});

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
          body: Column(

            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 30),

              FutureBuilder(
                future: Future.wait([
                  ApiManager.getCameras("camera/"),
                 // ApiManager.getMethod2("road/"),
                ]),

                builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(color: Colors.blue),
                    );
                  }
                  if (snapshot.hasError ) {
                    return Center(
                      child: Column(
                        children: [
                          Text( snapshot.error?.toString() ?? "Has Error"),
                          TextButton(onPressed: () {}, child: const Text("try again"))
                        ],
                      ),
                    );
                  }
                  var cameras = (snapshot.data?[0] as CamModel).camera??[];
                 // var road = (snapshot.data?[1] as RoadModel);
                  return
                    Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return
                          CameraItem(cameras[index]);
                      },
                      itemCount: cameras.length,
                    ),
                  );
                },
              )
            ],
          ),
        );

  }
  // Future<List<dynamic>> fetchData() async {
  //   final List<Future<dynamic>> futures = [
  //     CamModel(),
  //     RoadModel(),
  //   ];
  //
  //   return Future.wait(futures);
  // }
}
