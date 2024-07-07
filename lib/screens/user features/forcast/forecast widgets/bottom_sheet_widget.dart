import 'package:flutter/material.dart';
import 'package:graduation_project/screens/user%20features/forcast/forecast%20widgets/time_picker_textField.dart';
import 'DropdownList.dart';
import 'date_picker_text_field.dart';
import 'forecast_button.dart';
 // Import your dropdown widget here

class BottomSheetWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: <Widget>[
        MyAdvancedDropdown(), // Replace with your advanced dropdown widget
        const SizedBox(height: 16.0),
        DatePickerTextField(),
        const SizedBox(height: 16.0),
        TimePickerTextField(),
        const SizedBox(height: 50.0), // Adjust the height here
        ForecastButton(),
        const SizedBox(height: 16.0),
      ],
    );
  }
}
