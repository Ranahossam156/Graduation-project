import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// class CustomButton extends StatelessWidget {
//   final String label;
//   final String image_path;
//   final Color c;
//   const CustomButton({super.key, required this.label, required this.image_path, required this.c});
//
//   @override
//   Widget build(BuildContext context) {
//     return  Container(
//       width: 190,
//       height: 40,
//       decoration: BoxDecoration(
//
//         image: DecorationImage(
//           image: AssetImage(image_path),
//
//           fit: BoxFit.cover,
//
//
//         ),
//         borderRadius: BorderRadius.circular(5),
//       ),
//       child: Center(
//         child: Text(
//           label,
//           style: TextStyle(
//             color: c,
//             fontSize: 20,
//             fontWeight: FontWeight.w400,
//           ),
//         ),
//       ),
//     );
//   }
// }

class CustomButton extends StatelessWidget {
  final String label;
  final String imagePath;
  final Color c;
  final IconData? icon;

  CustomButton({required this.label, required this.imagePath, required this.c, this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 190,
      height: 40,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: TextStyle(
              color: c,
              fontSize: 20,
              fontWeight: FontWeight.w400,
            ),
          ),
          if (icon != null) ...[
            SizedBox(width: 8.0), // Add some space between the text and the icon
            Icon(icon, color: c),
          ],
        ],
      ),
    );
  }
}
