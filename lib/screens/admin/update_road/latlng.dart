import 'package:latlong2/latlong.dart';

List<LatLng> extractLatLngFromAddress(String address) {
  try {
    final regex = RegExp(r'(\d+\.\d+)-(\d+\.\d+)');
    final matches = regex.allMatches(address);
    if (matches.length < 2) {
      throw FormatException("Address does not contain two valid LatLng points");
    }

    final startLatLng = matches.elementAt(0);
    final endLatLng = matches.elementAt(1);

    final startLat = double.parse(startLatLng.group(1)!);
    final startLng = double.parse(startLatLng.group(2)!);
    final endLat = double.parse(endLatLng.group(1)!);
    final endLng = double.parse(endLatLng.group(2)!);

    return [LatLng(startLat, startLng), LatLng(endLat, endLng)];
  } catch (e) {
    print('Error parsing LatLng from address: $e');
    throw FormatException('Invalid address format for LatLng extraction');
  }
}
LatLng extractLatLngCameraLocation(String address) {
  try {

    final regex = RegExp(r'(\d+\.\d+)-(\d+\.\d+)');
    final matches = regex.allMatches(address);
    if (matches.length > 1) {
      print("road contain more than one valid LatLng points");
    }

    final startLatLng = matches.elementAt(0);


    final startLat = double.parse(startLatLng.group(1)!);
    final startLng = double.parse(startLatLng.group(2)!);

    return LatLng(startLat, startLng);
  } catch (e) {
    print('Error parsing LatLng from address: $e');
    throw FormatException('Invalid address format for LatLng extraction');
  }
}

String extractdescriptionFromAddress(String address) {
RegExp regExp = RegExp(r'^(\S+)\s*(.*)');
String firstWord="null";
Match? match = regExp.firstMatch(address);
if (match != null) {
firstWord = match.group(1) ?? '';

} else {
print('No match found.');
}
return firstWord;
}