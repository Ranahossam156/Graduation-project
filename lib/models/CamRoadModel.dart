import 'dart:convert';
import 'package:http/http.dart' as http;

import 'CamModel.dart';

class CamRoadModel {
  CamRoadModel({
    this.camera,
    this.roadCamera,
  });

  CamRoadModel.fromJson(dynamic json) {
    camera = json['Camera'] != null ? Camera.fromJson(json['Camera']) : null;
    roadCamera = json['RoadCamera'] != null ? RoadCamera.fromJson(json['RoadCamera']) : null;
  }

  Camera? camera;
  RoadCamera? roadCamera;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (camera != null) {
      map['Camera'] = camera?.toJson();
    }
    if (roadCamera != null) {
      map['RoadCamera'] = roadCamera?.toJson();
    }
    return map;
  }
}

class RoadCamera {
  RoadCamera({
    this.id,
    this.roadId,
    this.camId,
    this.dimensions,
    this.active,
    this.startDate,
    this.endDate,
  });

  RoadCamera.fromJson(dynamic json) {
    id = json['id'];
    roadId = json['road_id'];
    camId = json['cam_id'];
    dimensions = json['dimensions'];
    active = json['active'];
    startDate = json['start_date'];
    endDate = json['end_date'];
  }

  int? id;
  int? roadId;
  int? camId;
  String? dimensions;
  bool? active;
  String? startDate;
  dynamic endDate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['road_id'] = roadId;
    map['cam_id'] = camId;
    map['dimensions'] = dimensions;
    map['active'] = active;
    map['start_date'] = startDate;
    map['end_date'] = endDate;
    return map;
  }
}


class CameraData {
  final RoadCam roadCam;
  final CameraDetails cameraDetails;

  CameraData({required this.roadCam, required this.cameraDetails});

  factory CameraData.fromJson(Map<String, dynamic> json) {
    return CameraData(
      roadCam: RoadCam.fromJson(json['roadCam']),
      cameraDetails: CameraDetails.fromJson(json['cameraDetails']),
    );
  }
}

class RoadCam {
  final int id;
  final int roadId;
  final int camId;
  final String dimensions;
  final bool active;
  final String startDate;
  final String? endDate;

  RoadCam({
    required this.id,
    required this.roadId,
    required this.camId,
    required this.dimensions,
    required this.active,
    required this.startDate,
    this.endDate,
  });

  factory RoadCam.fromJson(Map<String, dynamic> json) {
    return RoadCam(
      id: json['id'],
      roadId: json['road_id'],
      camId: json['cam_id'],
      dimensions: json['dimensions'],
      active: json['active'],
      startDate: json['start_date'],
      endDate: json['end_date'],
    );
  }
}

class CameraDetails {
  final int id;
  final String model;
  final String? startService;
  final String factory;
  final String? imgsUrls;

  CameraDetails({
    required this.id,
    required this.model,
    this.startService,
    required this.factory,
    this.imgsUrls,
  });

  factory CameraDetails.fromJson(Map<String, dynamic> json) {
    return CameraDetails(
      id: json['id'],
      model: json['model'],
      startService: json['start_service'],
      factory: json['factory'],
      imgsUrls: json['imgs_urls'],
    );
  }
}


class AllCamerasResponse {
  final List<CameraData> allCameras;

  AllCamerasResponse({required this.allCameras});

  factory AllCamerasResponse.fromJson(Map<String, dynamic> json) {
    if (json.containsKey('AllCameras')) {
      return AllCamerasResponse(
        allCameras: List<CameraData>.from(json['AllCameras'].map((x) => CameraData.fromJson(x))),
      );
    } else if (json.containsKey('Road_Cams') && json.containsKey('Cameras')) {
      return AllCamerasResponse(
        allCameras: [
          CameraData.fromJson({
            'roadCam': json['Road_Cams'],
            'cameraDetails': json['Cameras'],
          })
        ],
      );
    } else {
      throw Exception('Invalid JSON structure');
    }
  }
}