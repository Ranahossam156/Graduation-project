class PlanModel {
  PlanModel({
      this.plans,});

  PlanModel.fromJson(dynamic json) {
    if (json['Plans'] != null) {
      plans = [];
      json['Plans'].forEach((v) {
        plans?.add(Plans.fromJson(v));
      });
    }
  }
  List<Plans>? plans;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (plans != null) {
      map['Plans'] = plans?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Plans {
  Plans({
      this.id, 
      this.name, 
      this.description, 
      this.type, 
      this.price, 
      this.discount, 
      this.periodInDays,});

  factory Plans.fromJson2(Map<String, dynamic> json) {
    return Plans(
      id: json['id'] ?? 0,
      name: json['name'] ?? 'Unknown',
      description: json['description'] ?? 'No description available',
      type: json['type'] ?? 'Unknown',
      price: json['price'] ?? 0,
      discount: json['discount']  ?? 0.0,
      periodInDays: json['period_in_days'] ?? 0,
    );
  }
  Plans.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    type = json['type'];
    price = json['price'];
    discount = json['discount'];
    periodInDays = json['period_in_days'];
  }
  int? id;
  String? name;
  String? description;
  String? type;
  int? price;
  dynamic? discount;
  int? periodInDays;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['description'] = description;
    map['type'] = type;
    map['price'] = price;
    map['discount'] = discount;
    map['period_in_days'] = periodInDays;
    return map;
  }

}