class CamModel {
  CamModel({
    this.message,
      this.camera,});

  CamModel.fromJson(dynamic json) {
    message=json['message'];
    if (json['camera'] != null) {
      camera = [];
      json['camera'].forEach((v) {
        camera?.add(Camera.fromJson(v));
      });
    }
  }
  List<Camera>? camera;
  String? message;
  Map<String, dynamic> toJson() {

    final map = <String, dynamic>{};
    map['message'] = message;
    if (camera != null) {
      map['camera'] = camera?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Camera {
  Camera({
    this.id,
    this.road_id,
    this.dimentions,
    this.model,
    this.startService,
   // this.endService,
    this.factory,
    this.message,
    this.active,
    this.imgsUrls,
  });

  Camera.fromJson(dynamic json) {
    id = json['id'];
   road_id = json['road_id'];
    dimentions = json['dimensions'];
    model = json['model'];
    startService = json['start_service'];
  //  endService = json['end_service'];
    factory = json['factory'];
    message = json['message'];
    active = json['active'];
    imgsUrls = json['imgs_urls'];
  }

  int? id;
  int? road_id;
  String? dimentions;
  String? model;
  String? message;
  dynamic startService;
//  dynamic endService;
  String? factory;
  bool? active;
  dynamic imgsUrls;
  Map<String, dynamic> toJsonupdate() {
    return {
      'road_id':road_id,
      'active': active,
      'model': model,
      'Factory': factory,
      'Start_Service': startService,
      'dimensions': dimentions,
    };
  }
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['road_id'] = road_id;
    map['dimentions'] = dimentions;
    map['model'] = model;
    map['message'] = message;
    map['Start_Service'] = startService;
  //  map['end_service'] = endService;
    map['Factory'] = factory;
    map['active'] = active;
    map['imgs_urls'] = imgsUrls;
    return map;
  }
  // Map<String, dynamic> toJsonupdate() {
  //   final map = <String, dynamic>{};
  //   map['id'] = id;
  //   map['road_id'] = road_id;
  //   map['dimensions'] = dimentions;
  //   map['model'] = model;
  //   map['message'] = message;
  //   map['Start_Service'] = startService;
  //   //  map['end_service'] = endService;
  //   map['Factory'] = factory;
  //   map['active'] = active;
  //   map['imgs_urls'] = imgsUrls;
  //   return map;
  // }
}