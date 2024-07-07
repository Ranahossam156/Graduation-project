import 'dart:convert';
import 'package:graduation_project/models/CamModel.dart';
import 'package:graduation_project/models/HistoryModel.dart';
import 'package:graduation_project/models/UserModel.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/CamRoadModel.dart';
import '../../models/ForcastingDataModel.dart';
import '../../models/ForcastingModel.dart';
import '../../models/PlanModel.dart';
import '../../models/RoadModel.dart';
import '../../models/SubscribtionsModel.dart';
import '../constant/constant.dart';
class ApiManager{

  static Future<dynamic> getCameras(String endPoint)async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    try{
      Uri url=Uri.https(Base,endPoint
            );
      http.Response response=await http.get(url,headers: {
        "Content-Type": "application/json",
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
     );
      var jsonData=jsonDecode(response.body);
      CamModel Response=CamModel.fromJson(jsonData);

      return Response;}

    catch(e){
      throw(e);
    }

  }

  Future<Map<String, dynamic>> updatePlan( Plans plan) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    String  endPoint="subscription/updatePlan/${plan.id}";
    Uri url=Uri.https(Base,endPoint
    );
    final response = await http.put(
      url,
      headers: {
        "Content-Type": "application/json",
        'Accept': 'application/json',
        'Authorization': 'Bearer $token', // Assuming you need a token for authorization
      },
      body: jsonEncode(plan.toJson()),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to update plan');
    }
  }
  static Future<PlanModel> getPlans()async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    String  endPoint="subscription/getPlans";
    try{
      Uri url=Uri.https(Base,endPoint
      );
      http.Response response=await http.get(url,headers: {
        "Content-Type": "application/json",
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      );
      var jsonData=jsonDecode(response.body);
      PlanModel Response=PlanModel.fromJson(jsonData);

      return Response;}

    catch(e){
      throw(e);
    }

  }

  static Future<CamRoadModel> getSpecificCamera(String endPoint) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    try {
      Uri url = Uri.https(Base, endPoint);
      http.Response response = await http.get(url, headers: {
        "Content-Type": "application/json",
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });
      var jsonData = jsonDecode(response.body);
      CamRoadModel camRoadModel = CamRoadModel.fromJson(jsonData);
      return camRoadModel;
    } catch (e) {
      throw e;
    }
  }


  static Future<RoadModel> getSpecificRoad(String endPoint) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    try {
      Uri url = Uri.https(Base, endPoint);
      http.Response response = await http.get(url, headers: {
        "Content-Type": "application/json",
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        print('API response: $jsonData');  // Debug: Print the API response
        RoadModel roadModel = RoadModel.fromJson2(jsonData);
        return roadModel;
      } else {
        print('Failed to load road: ${response.statusCode}');  // Debug: Print error code
        throw Exception('Failed to load road');
      }
    } catch (e) {
      print('Error: $e');  // Debug: Print the error
      throw e;
    }
  }

  static Future<List<RoadModel>> getRoads(String endPoint) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    List<RoadModel> _roads = [];

   // List<RoadModel> get roads => _roads;

    try {
      Uri url = Uri.https(Base, endPoint); // Replace 'your_base_url_here' with your actual base URL
      http.Response response = await http.get(url, headers: {
        "Content-Type": "application/json",
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });


      if (response.statusCode == 200) {
        final data = json.decode(response.body) as List;
        return _roads = data.map((road) => RoadModel.fromJson(road)).toList();
      } else {
        print('Failed to load road models: ${response.reasonPhrase}');
        throw Exception('Failed to load road models: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Failed to load road models: $e');
      throw Exception('Failed to load road models: $e');
    }
  }

  // static List<RoadModel> parseRoadModels(String responseBody) {
  //   final parsed = jsonDecode(responseBody) as List<dynamic>;
  //   return parsed.map<RoadModel>((json) => RoadModel.fromJson(json)).toList();
  // }
  static Future<void> PostRoad(RoadModel road) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    // Convert RoadModel instance to JSON
    Map<String, dynamic> jsonData = road.toJson();
    Uri url = Uri.https(Base, 'road/add');
    // Send POST request
    try {
      var response = await http.post(
          url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(jsonData),
      );

      if (response.statusCode == 201) {
        print('Road created successfully');
      } else {
        print('Failed to create road. Error ${response.statusCode}: ${response.body}');
      }
    } catch (e) {
      print('Exception caught: $e');
    }
  }
  static Future<void> deleteRoad(int id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    Uri url = Uri.https(Base,'road/$id');
    try {
      var response = await http.delete(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        print('Road with id $id deleted successfully');
      } else {
        print('Failed to delete road with id $id. Error ${response.statusCode}: ${response.body}');
      }
    } catch (e) {
      print('Exception caught: $e');
    }
  }
  static Future<void> deleteCamera(int id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    Uri url = Uri.https(Base,'camera/$id');
    try {
      var response = await http.delete(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        print('Camera with id $id deleted successfully');
      } else {
        print('Failed to delete camera with id $id. Error ${response.statusCode}: ${response.body}');
      }
    } catch (e) {
      print('Exception caught: $e');
    }
  }

  static Future<void> updateRoad(RoadModel updatedRoad) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    Map<String, dynamic> jsonData = updatedRoad.toJson();
    Uri url = Uri.https(Base,'road/update/${updatedRoad.id}');
     // Assuming API endpoint structure
    final response = await http.patch(
      url,
    headers: <String, String> {'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',},
      body: jsonEncode(jsonData),
    );

    if (response.statusCode == 200) {
      // Road updated successfully
    } else {
      // Handle error if update fails
      throw Exception('Failed to update road');
    }
  }

  static Future<void> updateCamera(Camera updatedCamera) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    try {
      Map<String, dynamic> jsonData = updatedCamera.toJsonupdate();
      Uri url = Uri.https(Base, '/road/camera/update/${updatedCamera.id}');

      print("URL: $url");
      print("Headers: ${{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      }}");
      print("Body: $jsonData");

      final response = await http.patch(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(jsonData),
      );

      if (response.statusCode == 200) {
        print("Camera updated successfully");
      } else {
        print('Failed to update camera. Error ${response.statusCode}: ${response.body}');
        throw Exception('Failed to update camera. Server responded with code ${response.statusCode}');
      }
    } catch (e) {
      print('Exception caught: $e');
      throw Exception('Failed to update camera');
    }
  }

  static Future<void> PostCam(Camera camera) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    Map<String, dynamic> jsonData = camera.toJson();
    Uri url = Uri.https(Base, 'camera/add');

    try {
      // Validate required fields
      if (camera.model == null || camera.model!.isEmpty) {
        print("Invalid camera model: ${camera.model}");
        throw Exception("Camera model cannot be null or empty");
      }
      if (camera.road_id == null) {
        print("Invalid road ID: ${camera.road_id}");
        throw Exception("Road ID cannot be null");
      }
      if (camera.active == null) {
        print("Invalid active status: ${camera.active}");
        throw Exception("Active status cannot be null");
      }

      // Additional detailed logging
      print("Sending JSON data: ${jsonEncode(jsonData)}");

      var response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(jsonData),
      );

      if (response.statusCode == 201) {
        print('Camera added successfully');
      } else {
        print('Failed to add camera. Error ${response.statusCode}: ${response.body}');
      }
    } catch (e) {
      print('Exception caught: $e');
    }
  }



  static Future<UserModel> getUsers(String endPoint)async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    try{
      Uri url=Uri.https(Base,endPoint
      );
      http.Response response=await http.get(url,headers: {
        "Content-Type": "application/json",
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      );
      var jsonData=jsonDecode(response.body);
      UserModel Response=UserModel.fromJson(jsonData);

      return Response;}

    catch(e){
      throw(e);
    }

  }
  static Future<Plans?> fetchPlanData(String endPoint) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    try {
      Uri url=Uri.https(Base,endPoint
      );
      http.Response response=await http.get(url,headers: {
        "Content-Type": "application/json",
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print('Response data: $data');
        if (data != null && data['Plan'] != null) {
          return Plans.fromJson2(data['Plan']);
        } else {
          throw Exception('Invalid response data');
        }
      } else {
        print('Failed to load plan, status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to load plan');
      }
    } catch (e) {
      print('Error fetching plan: $e');
      throw Exception('Failed to load plan');
    }
  }


  Future<Result?> fetchUserData(String endPoint) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    try {
      Uri url=Uri.https(Base,endPoint
      );
      http.Response response=await http.get(url,headers: {
        "Content-Type": "application/json",
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        if (jsonResponse['result'] != null) {
          return Result.fromJson(jsonResponse['result']);
        } else {
          print('No result key in response');
          return null;
        }
      } else {
        print('Failed to load user data: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error fetching user data: $e');
      return null;
    }
  }

  static Future<void> createAdmin(Result road) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    // Convert RoadModel instance to JSON
    Map<String, dynamic> jsonData = road.toJson();
    Uri url = Uri.https(Base, 'user/Admins');
    // Send POST request
    try {
      var response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(jsonData),
      );

      if (response.statusCode == 200) {
        print('Road created successfully');
      } else {
        print('Failed to create road. Error ${response.statusCode}: ${response.body}');
      }
    } catch (e) {
      print('Exception caught: $e');
    }
  }



  static Future<List<HistoryModel>> getHistory() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    Uri url = Uri.https(Base, "forecast"); // Replace 'your_base_url_here' with your actual base URL
    http.Response response = await http.get(url, headers: {
      "Content-Type": "application/json",
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode == 200) {
      final parsed = jsonDecode(response.body);
      final List<dynamic> recordsJson = parsed['records'];
      return recordsJson.map((json) => HistoryModel.fromJson(json)).toList();
    }
    else {
      throw Exception('Failed to load traffic records');
    }
  }

  static Future<List<HistoryModel>> getHistoryUser(int id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    Result? user = await ApiManager().fetchUserByToken(token!);
    //String token2="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InVzZXI4MjJAZ21haWwuY29tIiwiaWQiOjE5MjAyMiwiYWRtaW4iOmZhbHNlLCJpYXQiOjE3MjAxODU4MDYsImV4cCI6MTcyMjc3NzgwNn0.YpvQji08pPjo3Ub8_WBNIHB-_LnSKb-XiP4H3betUZk";
    Uri url = Uri.https(Base, "forecast/${user!.id}"); // Replace 'your_base_url_here' with your actual base URL
    http.Response response = await http.get(url, headers: {
      "Content-Type": "application/json",
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body)['data'];
      return data.map((json) => HistoryModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load traffic data');
    }
  }


  Future<SubscriptionsResponse2> fetchSubscriptions2(int id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    Uri url = Uri.https(Base, "subscription/getSub_by_plan/${id}");
    http.Response response = await http.get(url, headers: {
      "Content-Type": "application/json",
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode == 200) {
      return SubscriptionsResponse2.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load subscriptions');
    }}
  Future<dynamic> fetchSubscriptions() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    Uri url = Uri.https(Base, "subscription/getSub");
    http.Response response = await http.get(url, headers: {
      "Content-Type": "application/json",
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode == 200) {
      return SubscriptionsResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load subscriptions');
    }}


  Future<dynamic> fetchCameras(int id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
        Uri url = Uri.https(Base, "camera/cameras/${id}"); // Replace 'your_base_url_here' with your actual base URL
        http.Response response = await http.get(url, headers: {
          "Content-Type": "application/json",
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        });
    if (response.statusCode == 200) {
      return AllCamerasResponse.fromJson(json.decode(response.body));
    } else {
      // return Center(child: Text('No cameras found'));
      throw ('${json.decode(response.body)}');
    }
  }

  Future<String> Subscripe(String token,int amount,int planId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    // Define the URL for the POST request
    Uri url = Uri.https(Base, "subscription/subscribe");
    final Map<String, dynamic> payload = {
      "amount":amount,
      "planId": planId
    };

    // Send the POST request
    http.Response response = await http.post(url, headers: {

      "Content-Type": "application/json",
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    },
      body: json.encode(payload),
    );

    // Check if the request was successful
    if (response.statusCode == 200) {
      // Parse the JSON response
      final responseData = json.decode(response.body);
      // Get the iframe_url from the response
      final iframeUrl = responseData["iframe_url"];

      // Print the iframe_url
      print(iframeUrl);
      return iframeUrl;
    } else {
      print("Request failed with status code ${response.statusCode}");
      return ("Request failed with status code ${response.statusCode}");
    }
  }


  Future<Result?> fetchUserByToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    try {
      Uri url = Uri.https(Base, 'user/get_user_by_token'); // Replace with your actual base URL
      http.Response response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        return Result.fromJson(jsonResponse['user']);
      } else {
        print('Failed to load user data: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error fetching user data: $e');
      return null;
    }
  }


}

