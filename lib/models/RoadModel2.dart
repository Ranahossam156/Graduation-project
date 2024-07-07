class RoadModel2 {
  RoadModel2({
    this.id,
    this.name,
    this.address,
    this.message,
  });

  int? id;
  String? name;
  String? address;
  String? message;

  // factory RoadModel.fromJson(Map<String, dynamic> json) {
  //   return RoadModel(
  //     id: json['id'],
  //     name: json['name'],
  //     address: json['address'],
  //     message: json['message'],
  //   );
  // }
  factory RoadModel2.fromJson(Map<String, dynamic> json) {
    return RoadModel2(
      id: json['result']['id'],
      name: json['result']['name'],
      address: json['result']['address'],
    );}

}
