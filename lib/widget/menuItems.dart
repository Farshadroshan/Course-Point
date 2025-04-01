import 'package:coursepoint/widget/apppcolor.dart';
import 'package:flutter/material.dart';

class MenuItem extends StatelessWidget {
  final String text; // Text for the menu item
  final IconData icon; // Icon for the menu item
  final VoidCallback? onTap; // Action when the item is tapped

  const MenuItem({
    super.key,
    required this.text,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () {}, // Default empty callback if not provided
      child: Container(
        decoration: const BoxDecoration(
          // color: Color(0xFF191919),
        ),
        height: 40,
        child: Row(
          children: [
            Icon(
              icon,
              color: appColorblack
            ),
            const SizedBox(
              width: 25,
            ),
            Text(
              text,
              style:  TextStyle(
                color: appColorblack,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
