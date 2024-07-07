class HistoryModel {
  final int id;
  final int roadId;
  final DateTime date;
  final double trafficFlow;
  final String classification;

  HistoryModel ({
    required this.id,
    required this.roadId,
    required this.date,
    required this.trafficFlow,
    required this.classification,
  });

  factory HistoryModel.fromJson(Map<String, dynamic> json) {
    return HistoryModel (
      id: json['id'],
      roadId: json['road_id'],
      date: DateTime.parse(json['date']),
      trafficFlow: double.parse(json['traffic_flow']),
      classification: json['classification'],
    );
  }

}
