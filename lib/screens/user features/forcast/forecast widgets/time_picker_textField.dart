import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import '../../../../shared/constant/constants.dart';
import '../../../../shared/style/gradient_divider.dart'; // Import the intl package for time formatting
DateTime? selectedDateTime;
class TimePickerTextField extends StatefulWidget {
  const TimePickerTextField({super.key});

  @override
  _TimePickerTextFieldState createState() => _TimePickerTextFieldState();
}

class _TimePickerTextFieldState extends State<TimePickerTextField> {
 // DateTime? _selectedDateTime;

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(primary: Constants.primaryColor),
            buttonTheme: const ButtonThemeData(
              textTheme: ButtonTextTheme.primary,
              colorScheme: ColorScheme.light(primary: Constants.primaryColor),
            ),
          ),
          child: child!,
        );
      },
    );
    if (pickedTime != null) {
      final now = DateTime.now();
      final pickedDateTime = DateTime(now.year, now.month, now.day, pickedTime.hour, pickedTime.minute, now.second);

      if (pickedDateTime != selectedDateTime) {
        setState(() {
          selectedDateTime = pickedDateTime;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Format the selected time to display in the text field including seconds
    String formattedTime = selectedDateTime != null
        ? DateFormat('HH:mm:ss').format(selectedDateTime!)
        : '';

    return Column(
      children: [
        TextFormField(
          readOnly: true,
          decoration: InputDecoration(
            labelText: 'Select Time',
            border: InputBorder.none,
            labelStyle: const TextStyle(color: Constants.primaryColor),
            suffixIcon: IconButton(
              icon: const Icon(Icons.access_time, color: Constants.primaryColor),
              onPressed: () {
                _selectTime(context);
              },
            ),
          ),
          controller: TextEditingController(text: formattedTime),
          onTap: () {
            _selectTime(context);
          },
        ),
        const GradientDivider(),
      ],
    );
  }
}
