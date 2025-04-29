
// import 'package:coursepoint/screens/user/user_chatbot_page.dart';

import 'package:coursepoint/Screens/user/user_home.dart';
import 'package:coursepoint/screens/user/user_chatbot_page.dart';

import 'package:flutter/material.dart';

class ChatBotBox extends StatelessWidget {
  const ChatBotBox({
    super.key,
    required this.widget,
  });

  final UserhomeScreen widget;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: GestureDetector(
       onTap: () {
         
       },
        child: 
       
       Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            spreadRadius: 2,
            offset: Offset(0, 4),
          ),
        ],
        image: DecorationImage(
          image: AssetImage('assets/robot_text.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          // Gradient overlay for better text visibility
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(0.4),
                  Colors.transparent,
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
          ),
    
          // Chatbot title & button
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Chat with AI',
                  style: TextStyle(
     fontSize: 22,
     color: Colors.white,
     fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                GestureDetector(
                  onTap: () {
     // Navigate to chatbot screen
     Navigator.push(context, MaterialPageRoute(builder: (ctx)=>ChatScreen(userId: widget.userLogindata.id!)));
                  },
                  child: Container(
     padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
     decoration: BoxDecoration(
       color: Colors.blueAccent,
       borderRadius: BorderRadius.circular(10),
       boxShadow: [
         BoxShadow(
           color: Colors.blueAccent.withOpacity(0.5),
           blurRadius: 5,
           spreadRadius: 1,
         ),
       ],
     ),
     child: Text(
       'Click here',
       style: TextStyle(
         fontSize: 18,
         color: Colors.white,
         fontWeight: FontWeight.w600,
       ),
     ),
                  ),
                ),
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
