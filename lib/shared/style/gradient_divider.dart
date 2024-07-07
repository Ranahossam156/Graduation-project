import 'package:flutter/material.dart';

class GradientDivider extends StatelessWidget {
  const GradientDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xff076092)
                .withOpacity(0.2), // Transparent blue at the start
            const Color(0xff076092), // Solid blue in the middle
            const Color(0xff076092)
                .withOpacity(0.2), // Transparent blue at the end
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Center(
        child: Divider(
          color: Colors.transparent,
          height: MediaQuery.of(context).size.width * 0.009,
          thickness: 0.005,
          indent: MediaQuery.of(context).size.width * 0.04,
          endIndent: MediaQuery.of(context).size.width * 0.04,
        ),
      ),
    );
  }
}
