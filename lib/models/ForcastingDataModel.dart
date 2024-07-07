class RoadData {
  final int roadId;
  final String date;
  final String time;

  RoadData({required this.roadId, required this.date, required this.time});

  Map<String, dynamic> toJson() {
    return {
      'road_id': roadId,
      'date': date,
      'time': time,
    };
  }

  factory RoadData.fromJson(Map<String, dynamic> json) {
    return RoadData(
      roadId: json['road_id'],
      date: json['date'],
      time: json['time'],
    );
  }
}
