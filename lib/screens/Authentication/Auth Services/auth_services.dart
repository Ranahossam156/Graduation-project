// auth_service.dart

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:graduation_project/shared/constant/end_ponits.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:graduation_project/cache/cache_helper.dart';
import 'package:graduation_project/models/UserModel.dart';
import 'package:graduation_project/shared/remote/api_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../admin/admin_home.dart';
import '../../user features/forcast/forecast screens/forcasting_screen.dart';
import '../Authentication screens/forget_password_otp.dart';
import '../Authentication screens/login_screen.dart';
import '../Authentication screens/reset_password_screen.dart';

class AuthService {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> register({
    required String name,
    required String email,
    required String password,
    required String address,
    required BuildContext context,
  }) async {
    try {
      var headers = {'Content-Type': 'application/json'};
      var url = Uri.parse(EndPoint.baseUrl + EndPoint.register);
      Map body = {
        'name': name,
        'email': email,
        'password': password,
        'car_license': "#######",
        'address': address,
      };

      http.Response response = await http.post(url, body: jsonEncode(body), headers: headers);
      if (response.statusCode >= 200 && response.statusCode <= 300) {
        print(response.body);
        final json = jsonDecode(response.body);
        var token = json['data']['user']['token'];
        print(token);
        final SharedPreferences? prefs = await _prefs;
        await prefs?.setString('token', token);

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ),
        );
      } else {
        throw jsonDecode(response.body)['message'] ?? "Unknown Error Occurred";
      }
      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');
    } catch (error) {
      Get.back();
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
  Future<void> login(
      {required String email,
        required String password,
        required BuildContext context}) async {
    try {
      var headers = {"Content-Type": "application/json"};

      var url = Uri.parse(EndPoint.baseUrl + EndPoint.login);
      Map body = {
        'email': email,
        'password': password,
      };

      http.Response response =
      await http.post(url, body: jsonEncode(body), headers: headers);
      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');
      if (response.statusCode >= 200 && response.statusCode <= 300) {
        print(response.body);
        final json = jsonDecode(response.body);
        var token = json['token'];
        print('Token: $token'); // Print the token to check its value

        // Decode the token
        Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
        print('Decoded Token: $decodedToken'); // Print decoded token

        // Save token and ID in SharedPreferences
        await CacheHelper().saveData(key: ApiKey.token, value: token);
        await CacheHelper().saveData(
            key: ApiKey.id, value: decodedToken[ApiKey.id]);
        print('Token and ID saved in SharedPreferences'); // Confirm the token and ID are saved

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
  Future<void> verifyCode({
    required String code,
    required String email,
    required BuildContext context,
  }) async {
    try {
      var headers = {"Content-Type": "application/json"};

      var url = Uri.parse(EndPoint.baseUrl + EndPoint.verifyCode);
      Map body = {
        'code': code,
      };

      http.Response response = await http.post(url, body: jsonEncode(body), headers: headers);
      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');
      if (response.statusCode >= 200 && response.statusCode <= 300) {
        print(response.body);
        final json = jsonDecode(response.body);

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ResetPasswordScreen(email: email)),
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
  Future<void> forgetPassword({
    required String email,
    required BuildContext context,
  }) async {
    try {
      var headers = {"Content-Type": "application/json"};
      var url = Uri.parse(EndPoint.baseUrl + EndPoint.forgot);
      Map body = {'email': email};

      http.Response response = await http.post(url, body: jsonEncode(body), headers: headers);
      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');
      if (response.statusCode >= 200 && response.statusCode <= 300) {
        print(response.body);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => OTPScreen(email: email)),
        );
      } else {
        throw jsonDecode(response.body)['message'] ?? "Unknown error occurred";
      }
    } catch (error) {
      showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: const Text('Error'),
            contentPadding: const EdgeInsets.all(20),
            children: [Text(error.toString())],
          );
        },
      );
    }
  }
  Future<void> resetPassword({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      var headers = {"Content-Type": "application/json"};
      var url = Uri.parse(EndPoint.baseUrl + EndPoint.resetPass);
      Map body = {
        'email': email,
        'password': password,
      };

      http.Response response = await http.put(url, body: jsonEncode(body), headers: headers);
      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');
      if (response.statusCode >= 200 && response.statusCode <= 300) {
        print(response.body);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      } else {
        throw jsonDecode(response.body)['message'] ?? "Unknown error occurred";
      }
    } catch (error) {
      showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: const Text('Error'),
            contentPadding: const EdgeInsets.all(20),
            children: [Text(error.toString())],
          );
        },
      );
    }
  }
}
