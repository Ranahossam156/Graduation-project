import 'dart:convert';

class SubscriptionModel {
  final int id;
  final int userId;
  final int planId;
  final DateTime startDate;
  final DateTime endDate;

  SubscriptionModel ({
    required this.id,
    required this.userId,
    required this.planId,
    required this.startDate,
    required this.endDate,
  });

  factory SubscriptionModel .fromJson(Map<String, dynamic> json) {
    return SubscriptionModel (
      id: json['id'],
      userId: json['user_id'],
      planId: json['plan_id'],
      startDate: DateTime.parse(json['start_date']),
      endDate: DateTime.parse(json['end_date']),
    );
  }
}

class SubscriptionsResponse {
  final List<SubscriptionModel > subscriptions;

  SubscriptionsResponse({required this.subscriptions});

  factory SubscriptionsResponse.fromJson(Map<String, dynamic> json) {
    var list = json['Subscriptios'] as List;
    List<SubscriptionModel > subscriptionsList = list.map((i) => SubscriptionModel .fromJson(i)).toList();
    return SubscriptionsResponse(subscriptions: subscriptionsList);
  }
}

class SubscriptionsResponse2 {
  final List<SubscriptionModel> subscriptions;

  SubscriptionsResponse2({required this.subscriptions});

  factory SubscriptionsResponse2.fromJson(Map<String, dynamic> json) {
    if (json['Subscription'] is List) {
      // Handle the case where it's a list of subscriptions
      var list = json['Subscription'] as List;
      List<SubscriptionModel> subscriptionsList = list.map((i) => SubscriptionModel.fromJson(i)).toList();
      return SubscriptionsResponse2(subscriptions: subscriptionsList);
    } else if (json['Subscription'] is Map) {
      // Handle the case where it's a single subscription object
      SubscriptionModel singleSubscription = SubscriptionModel.fromJson(json['Subscription']);
      return SubscriptionsResponse2(subscriptions: [singleSubscription]);
    } else {
      throw Exception('Invalid JSON structure');
    }
  }
}
