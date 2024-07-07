import 'package:flutter/material.dart';
import 'package:graduation_project/models/RoadModel.dart';
import '../../../../shared/constant/constants.dart';
import '../../../../shared/remote/api_manager.dart';
int roadId=0;
class MyAdvancedDropdown extends StatefulWidget {
  const MyAdvancedDropdown({Key? key}) : super(key: key);

  @override
  _MyAdvancedDropdownState createState() => _MyAdvancedDropdownState();
}

class _MyAdvancedDropdownState extends State<MyAdvancedDropdown> {
  RoadModel? _selectedItem;
  List<RoadModel> _dropdownItems = [];
  String? _errorMessage;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchRoads();
  }

  void _fetchRoads() async {
    setState(() {
      _isLoading = true;
    });

    try {
      var response = await ApiManager.getRoads("road/");
      setState(() {
        _dropdownItems = response;
        _isLoading = false;
      });
    } catch (error) {
      setState(() {
        _errorMessage = 'Error fetching roads: $error';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: _isLoading
            ? CircularProgressIndicator()
            : _errorMessage != null
            ? Text(_errorMessage!)
            : DropdownButtonFormField<RoadModel>(
          focusColor: Constants.primaryColor,
          value: _selectedItem,
          onChanged: (RoadModel? value) {
            setState(() {
              _selectedItem = value;
            });
            // Perform any action on road selection
          },
          decoration: InputDecoration(
            labelText: 'Select a road',
            labelStyle: TextStyle(color: Constants.primaryColor),
            floatingLabelStyle: TextStyle(color: Constants.primaryColor),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Constants.primaryColor,
              ),
            ),
          //  suffixIcon: Icon(Icons.arrow_drop_down, color: Constants.primaryColor),
          ),
          items: _dropdownItems.map<DropdownMenuItem<RoadModel>>((RoadModel road) {
            roadId=road.id!;
            return DropdownMenuItem<RoadModel>(
              value: road,
              child: Row(
                children: [
                  Icon(Icons.location_on, color: Constants.primaryColor),
                  SizedBox(width: 10),
                  Text(
                    road.name!,
                    style: TextStyle(color: Constants.primaryColor),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
