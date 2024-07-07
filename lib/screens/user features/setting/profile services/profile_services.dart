// profile_service.dart

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../../models/UserModel.dart';
import '../../../../shared/constant/end_ponits.dart';
import '../../../../shared/remote/api_manager.dart';
import '../../../admin/admin_home.dart';
import '../../forcast/forecast screens/forcasting_screen.dart';

class ProfileService {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> updateProfile({
    required String name,
    required String email,
    required String address,
    required String carLicense,
    required String password,
    required BuildContext context,
  }) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');
      print('Retrieved Token: $token');

      var headers = {"Content-Type": "application/json"};
      if (token != null) {
        headers['Authorization'] = 'Bearer $token';
      }

      var url = Uri.parse(EndPoint.baseUrl + EndPoint.update);
      Map body = {
        'email': email,
        'name': name,
        'address': address,
        'car_license': carLicense,
        'password': password,
      };

      http.Response response = await http.patch(url, body: jsonEncode(body), headers: headers);
      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode >= 200 && response.statusCode < 300) {
        print(response.body);
        Result? user = await ApiManager().fetchUserByToken(token!);
        if (user?.isAdmin == false) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ForecastingScreen()),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AdminHome()),
          );
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Updated Successfully')),
        );
      } else {
        throw jsonDecode(response.body)['message'] ?? "Unknown error occurred";
      }
    } catch (error) {
      showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: Text('Error'),
            contentPadding: EdgeInsets.all(20),
            children: [Text(error.toString())],
          );
        },
      );
    }
  }
  Future<void> changePassword({
    required String password,
    required String newPassword,
    required BuildContext context,
  }) async {
    try {
      var headers = {"Content-Type": "application/json"};
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');
      print('Retrieved Token: $token'); // Print the token to check its value

      if (token != null) {
        headers['Authorization'] = 'Bearer $token';
      }

      var url = Uri.parse(EndPoint.baseUrl + EndPoint.changePass);
      Map body = {
        'newpass': newPassword,
        'password': password,
      };

      http.Response response = await http.patch(url, body: jsonEncode(body), headers: headers);
      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode >= 200 && response.statusCode < 300) {
        print(response.body);
        showDialog(
          context: context,
          builder: (context) {
            return const SimpleDialog(
              title: Text('Updated Successfully'),
              contentPadding: EdgeInsets.all(20),
              children: [Text('')],
            );
          },
        );
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ForecastingScreen()),
        );
      } else {
        throw jsonDecode(response.body)['message'] ?? "Unknown error occurred";
      }
    } catch (error) {
      showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: Text('Error'),
            contentPadding: EdgeInsets.all(20),
            children: [Text(error.toString())],
          );
        },
      );
    }
  }
}
