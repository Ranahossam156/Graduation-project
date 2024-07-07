import 'package:flutter/material.dart';
import '../../../models/UserModel.dart';
import '../../../shared/style/detailsItem.dart';
import '../../user features/setting/edit_profile_screen.dart';
import '../drawer_screen.dart';

class AdminProfile extends StatelessWidget {
  final Result user;

  AdminProfile ({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${user.name}'),
        backgroundColor: Color.fromRGBO(14, 46, 92, 1),
      ),
      body: ListView(
        padding: EdgeInsets.all(20.0),
        children: [
          Column(
            children: [
              Image.asset(
                'assets/images/profile.png', // Add your image path here
                width: 180,
                height: 180,
              ),
              SizedBox(height: 15.0),
              buildDetailItem(label: 'ID', value: user.id),
              buildDetailItem(label: 'Name', value: user.name),
              buildDetailItem(label: 'Address', value: user.address ?? ""),
              buildDetailItem(label: 'Email', value: user.email),
              buildDetailItem(label: 'Admin', value: user.isAdmin.toString()),
              buildDetailItem(label: 'Premium', value: user.isPremium.toString()),
              buildDetailItem(label: 'Car License', value: user.carLicense ?? ""),
              buildDetailItem(label: 'Reset Code', value: user.resetCode ?? ""),
              buildDetailItem(label: 'Last Reset Date', value: user.lastResetDate ?? ""),
              buildDetailItem(label: 'Verified', value: user.isVerified.toString()),
              buildDetailItem(label: 'Avatar', value: user.avatar ?? ""),
            ],
          ),
        ],
      ),
      endDrawer: DrawerScreen(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to the edit screen or perform editing functionality
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => EditProfileScreen(user: user)),
          );
        },
        backgroundColor: Color.fromRGBO(14, 46, 92, 1),
        child: Icon(Icons.edit),
      ),
    );
  }
}


