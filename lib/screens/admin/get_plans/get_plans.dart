import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../models/PlanModel.dart';
import '../../../shared/remote/api_manager.dart';
import '../../user features/premium/plan_user_item.dart';
import '../admin_home.dart';
import '../drawer_screen.dart';
import 'PlanItem.dart';


class GetPlan extends StatelessWidget {
  static const String routName="EditCamera";
  final bool isUser ;
  const GetPlan({required this.isUser});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed:() {Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AdminHome()));},
        ),
        backgroundColor: Color.fromRGBO(14,46,92,1),
      ),
      body: Column(

        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 30),

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
                      if(isUser==false)
                      return
                        PlanItem(plans[index]);
                      else
                        return PlanUserItem(plans[index]);
                    },
                    itemCount: plans.length,
                  ),
                );
            },
          )
        ],
      ),
      endDrawer: DrawerScreen(),
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
