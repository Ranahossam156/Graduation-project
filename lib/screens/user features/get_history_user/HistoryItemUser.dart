import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/models/HistoryModel.dart';
import '../../../models/RoadModel.dart';
import '../../../shared/remote/api_manager.dart';
import '../../admin/update_road/latlng.dart';

class HistoryUserItem extends StatefulWidget {
  final HistoryModel history;

  HistoryUserItem(this.history, {super.key});

  @override
  _HistoryUserItemState createState() => _HistoryUserItemState();
}

class _HistoryUserItemState extends State<HistoryUserItem> {
  RoadModel? roadData;

  @override
  void initState() {
    super.initState();
    fetchRoadData();
  }

  void fetchRoadData() async {
    try {
      roadData = await ApiManager.getSpecificRoad("road/${widget.history.roadId}");
      setState(() {}); // Update the state to refresh the UI
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    String address =roadData?.address ?? 'Loading...';
    return Card(
      color: Color.fromRGBO(14, 46, 92, 1),
      elevation: 12,
      margin: EdgeInsets.symmetric(horizontal: 25, vertical: 8),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: Colors.transparent)),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Center(
          child: Row(
            children: [
              SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Date : ${widget.history.date}",
                      style: TextStyle(
                        fontSize: 17,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Road Address : ${extractdescriptionFromAddress(address)}",
                      style: TextStyle(
                        fontSize: 17,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Congestion Rate : ${widget.history.classification}",
                      style: TextStyle(
                        fontSize: 17,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Traffic Flow : ${widget.history.trafficFlow}",
                      style: TextStyle(
                        fontSize: 17,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 5),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
