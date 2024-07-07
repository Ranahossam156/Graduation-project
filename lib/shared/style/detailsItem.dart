import 'package:flutter/cupertino.dart';

class buildDetailItem extends StatelessWidget {
  String label;
  var value;
  buildDetailItem({required this.label, required this.value });


  @override
  Widget build(BuildContext context) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 8.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),
          ),
        ),
        SizedBox(width: 15.0),
        Expanded(
          flex: 3,
          child: Text(value.toString(),
            style: TextStyle(fontSize: 15),),

        ),
      ],
    ),
  );
}}