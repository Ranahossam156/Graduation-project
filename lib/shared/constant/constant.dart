const  String Base="graduation-project-fdvx.onrender.com";
//const  String token="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6IjExNDEwMTIwMjAwNDE0QHN0dWQuY3UuZWR1LmVnIiwiaWQiOjUxMzAwMCwiYWRtaW4iOnRydWUsImlhdCI6MTcxODgwNDAwOSwiZXhwIjoxNzIxMzk2MDA5fQ.Nesb3X49i3iRU6HxwJGGH1HEBAakEWNbhjYSCb0k2us";

String formatDate(DateTime dateTime) {
  return '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}';
}

String formatTime(DateTime dateTime) {
  return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}:${dateTime.second.toString().padLeft(2, '0')}';
}