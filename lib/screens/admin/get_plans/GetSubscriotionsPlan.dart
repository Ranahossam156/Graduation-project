import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/screens/admin/drawer_screen.dart';
import 'package:graduation_project/shared/remote/api_manager.dart';

import '../../../models/SubscribtionsModel.dart';
import 'SubscriotionsPlanItem.dart';

class SubscriptionsPlanPage extends StatelessWidget {
  int id;
  SubscriptionsPlanPage( this.id);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(14,46,92,1),
        title: Text('Subscriptions'),
      ),
      body: FutureBuilder<SubscriptionsResponse2>(
        future: ApiManager().fetchSubscriptions2(id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final subscriptions = snapshot.data!.subscriptions;
            return ListView.builder(
              itemCount: subscriptions.length,
              itemBuilder: (context, index) {
                final subscription = subscriptions[index];
                return SubscribtionsPlanItem(
                    subscription
                );
              },
            );
          } else {
            return Center(child: Text('No subscriptions found'));
          }
        },
      ),
      endDrawer: DrawerScreen(),
    );
  }
}