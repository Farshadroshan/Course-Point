
   
  
import 'package:coursepoint/widget/apppcolor.dart';
import 'package:flutter/material.dart';
   
   
   Widget buildActionButton(BuildContext context, String text, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 0, 0, 20),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(Colors.blueGrey.shade100),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        child: Text(
          text,
          style:  TextStyle(color: appColorblack),
        ),
      ),
    );
  }