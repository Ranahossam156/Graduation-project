class UserModel {
  UserModel({
      this.result,});

  UserModel.fromJson(dynamic json) {
    if (json['result'] != null) {
      result = [];
      json['result'].forEach((v) {
        result?.add(Result.fromJson(v));
      });
    }
  }
  List<Result>? result;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (result != null) {
      map['result'] = result?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Result {
  Result(
      {
      this.id, 
      this.name, 
      this.address, 
      this.email, 
      this.password, 
      this.isAdmin,
      this.isPremium,
      this.carLicense, 
      this.resetCode, 
      this.lastResetDate, 
      this.isVerified, 
      this.avatar,
      }
      );
  // factory Result.fromJsonToken(Map<String, dynamic> json) {
  //   return Result(
  //     id: json['user']['id'],
  //     name: json['user']['name'],
  //     address: json['user']['address'],
  //     email: json['user']['email'],
  //     password: json['user']['password'],
  //     isAdmin: json['user']['is_admin'],
  //     isPremium: json['user']['is_premium'],
  //     carLicense: json['user']['car_license'],
  //     resetCode: json['user']['reset_code'],
  //     lastResetDate: json['user']['last_reset_date'] != null
  //         ? DateTime.parse(json['user']['last_reset_date'])
  //         : null,
  //     isVerified: json['user']['is_verified'],
  //     avatar: json['user']['avatar'],
  //   );
  // }
  Result.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    email = json['email'];
    password = json['password'];
    isAdmin = json['is_admin'];
    isPremium = json['is_premium'];
    carLicense = json['car_license'];
    resetCode = json['reset_code'];
    lastResetDate = json['last_reset_date'];
    isVerified = json['is_verified'];
    avatar = json['avatar'];
  }

  // Result.fromJson2(dynamic json) {
  //   id = json['id'];
  //   name = json['name'];
  //   address = json['address'];
  //   email = json['email'];
  //   password = json['password'];
  //   isAdmin = json['is_admin'];
  //   isPremium = json['is_premium'];
  //   carLicense = json['car_license'];
  //   resetCode = json['reset_code'];
  //   lastResetDate = json['last_reset_date'];
  //   isVerified = json['is_verified'];
  //   avatar = json['avatar'];
  // }
  factory Result.fromJson2(Map<String, dynamic> json) {
    return Result(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      address: json['address'] ?? '',
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      isAdmin: json['is_admin'] ?? false,
      isPremium: json['is_premium'] ?? false,
      carLicense: json['car_license'] ?? '',
      resetCode: json['reset_code'],
      lastResetDate: json['last_reset_date'] != null
          ? DateTime.parse(json['last_reset_date'])
          : DateTime.now(),
      isVerified: json['is_verified'] ?? false,
      avatar: json['avatar'],
    );
  }
  int? id;
  String? name;
  String? address;
  String? email;
  String? password;
  bool? isAdmin;
  bool? isPremium;
  String? carLicense;
  dynamic resetCode;
  dynamic lastResetDate;
  dynamic isVerified;
  dynamic avatar;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{} ;
    map['id'] = id;
    map['name'] = name;
    map['address'] = address;
    map['email'] = email;
    map['password'] = password;
    map['is_admin'] = isAdmin;
    map['is_premium'] = isPremium;
    map['car_license'] = carLicense;
    map['reset_code'] = resetCode;
    map['last_reset_date'] = lastResetDate;
    map['is_verified'] = isVerified;
    map['avatar'] = avatar;
    return map;
  }

}


 // Result.fromJson2(Map<String, dynamic> json) {
 //
 //      id: json['id'],
 //      name: json['name'],
 //      address: json['address'],
 //      email: json['email'],
 //      password: json['password'],
 //      isAdmin: json['is_admin'],
 //      isPremium: json['is_premium'],
 //      carLicense: json['car_license'],
 //      resetCode: json['reset_code'],
 //      lastResetDate: DateTime.parse(json['last_reset_date']),
 //      isVerified: json['is_verified'],
 //      avatar: json['avatar'],
 //     }
//}