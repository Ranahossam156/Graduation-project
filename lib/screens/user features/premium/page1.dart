import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/screens/user%20features/premium/plan_user_item.dart';
import '../../../models/PlanModel.dart';
import '../../../shared/remote/api_manager.dart';

class Page1_Premium extends StatelessWidget {
  static const String routName="premium";
  const Page1_Premium({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Color.fromRGBO(14,46,92,1) ,
      body: Column(

        children: [
          Expanded(

            child:  Stack(
              children: [
                Container(
                  height: 300,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(14, 46, 92, 1),
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    ), // Adjust the value as needed
                  ),
                ),
                Center(
                  child: Image.asset(
                    'assets/images/logo.png', // Add your image path here
                    width: 320,
                    height: 320,
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    'Forecast for more than 7 days!',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                Positioned(
                  top: 15, // Adjust the position as needed
                  right: 10, // Adjust the position as needed
                  child: IconButton(
                    icon: Icon(
                      Icons.cancel,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      // Add your cancel action here
                    },
                  ),
                ),
              ],
            )
,
          ),SizedBox(height:40),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.white, width: 2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'UPGRADE TO PREMIUM',
                        style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,color: Color(0xff076092)),
                      ),
                      SizedBox(height: 20),

                      FutureBuilder(
                        future: Future.wait([
                          ApiManager.getPlans(),
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
                          var plans = (snapshot.data?[0] as PlanModel).plans??[];
                          // var road = (snapshot.data?[1] as RoadModel);
                          return
                            Expanded(
                              child: ListView.builder(
                                itemBuilder: (context, index) {

                                  return PlanUserItem(plans[index]);
                                },
                                itemCount: plans.length,
                              ),
                            );
                        },
                      ),

                    ],
                  ),
                ),
              ),
            ),),
        ],
      ),
    );
  }
}