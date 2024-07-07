import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String labelText;
  final bool obscureText;
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final Color textColor;
  final IconData? iconData; // New property for icon
  final VoidCallback? onPressed; // Callback for button press

  const CustomTextFormField({
    Key? key,
    this.obscureText = false,
    required this.labelText,
    required this.validator,
    required this.controller,
    required this.keyboardType,
    this.textColor = Colors.white,
    this.iconData,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.005,
      ),
      child: TextFormField(
        style: TextStyle(color: textColor),
        textInputAction: TextInputAction.next,
        obscureText: obscureText,
        validator: validator,
        cursorColor: Color(0xff076092),
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(
            color: Color(0xff076092),
            fontSize: 18,
          ),
          contentPadding: const EdgeInsets.only(bottom: 4),
          border: UnderlineInputBorder(),
          suffixIcon: iconData != null
              ? Container(
            width: 48,
            height: 48,
            child: IconButton(
              icon: Icon(
                iconData,
                color: textColor,
              ),
              onPressed: onPressed,
            ),
          )
              : null,
        ),
      ),
    );
  }
}
