import 'dart:convert';
import 'package:graduation_project/models/CamModel.dart';
import 'package:graduation_project/models/HistoryModel.dart';
import 'package:graduation_project/models/UserModel.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../models/ForcastingDataModel.dart';
import '../../../../models/ForcastingModel.dart';
import '../../../../shared/constant/constant.dart';
class ForecastServices{
  Future<VehicleForecast> sendForecastingData(RoadData roadData) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    Map<String, dynamic> jsonData = roadData.toJson();
    Uri url = Uri.https(Base, 'forecast/calc');
    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(jsonData),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> responseJson = jsonDecode(response.body);
      print('API Response: $responseJson');
      return VehicleForecast.fromJson(responseJson);
    } else {
      throw Exception('Failed to send road data');
    }
  }
}

