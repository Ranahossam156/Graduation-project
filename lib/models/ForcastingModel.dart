class VehicleForecast {
  final double carCount;
  final String classificationOfTraffic;
  final double accuracy;
  final List<SummaryEntry> summary;

  VehicleForecast({
    required this.carCount,
    required this.classificationOfTraffic,
    required this.accuracy,
    required this.summary,
  });

  factory VehicleForecast.fromJson(Map<String, dynamic> json) {
    List<dynamic> summaryList = json['summary'];
    List<SummaryEntry> parsedSummary = summaryList.map((entry) => SummaryEntry.fromJson(entry)).toList();

    print('Parsing VehicleForecast:');
    print('Car_Count: ${json['Car_Count']}');
    print('classification_of_traffic: ${json['classification_of_traffic']}');
    print('accuracy: ${json['accuracy']}');
    print('summary: ${json['summary']}');

    return VehicleForecast(
      carCount: json['Car_Count'],
      classificationOfTraffic: json['classification_of_traffic'],
      accuracy: json['accuracy'],
      summary: parsedSummary,
    );
  }
}

class SummaryEntry {
  final String date;
  final double vehicles;

  SummaryEntry({
    required this.date,
    required this.vehicles,
  });

  factory SummaryEntry.fromJson(Map<String, dynamic> json) {
    print('Parsing SummaryEntry:');
    print('Date: ${json['Date']}');
    print('Vehicles: ${json['Vehicles']}');

    return SummaryEntry(
      date: json['Date'],
      vehicles: json['Vehicles'],
    );
  }
}
