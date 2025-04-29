
// import 'dart:convert';
// import 'dart:io';
import 'package:coursepoint/DataBase/Functions/database_functions.dart';
import 'package:coursepoint/DataBase/Model/courses_model.dart';
// import 'package:coursepoint/Screens/user/user_course_details.dart';
import 'package:coursepoint/Screens/user/user_menu.dart';
import 'package:coursepoint/database/model/user_login_model.dart';
// import 'package:coursepoint/screens/user/user_chatbot_page.dart';
import 'package:coursepoint/widget/apppcolor.dart';
import 'package:coursepoint/widget/chat_bot_box.dart';
// import 'package:coursepoint/widget/chat_bot_button_widget.dart';
import 'package:coursepoint/widget/colors.dart';
import 'package:coursepoint/widget/user_app_bar.dart';
import 'package:coursepoint/widget/user_course_grid_view_widget.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class UserhomeScreen extends StatefulWidget {
  const UserhomeScreen({super.key, required this.userLogindata});
  final UserLoginModel userLogindata;

  @override
  State<UserhomeScreen> createState() => _UserhomeScreenState();
}

class _UserhomeScreenState extends State<UserhomeScreen> {
  late TextEditingController searchController;
  bool isSearchActive = false;
  List<CoursesModel> filteredCourses = [];
  String userName = 'Guest';

  void searchCourse(String query) {
    setState(() {
      filteredCourses = coursesListNotifier.value
          .where((course) => course.coursetitle.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }
  void closeSearch() {
    setState(() {
      isSearchActive = false;
      searchController.clear();
      filteredCourses = coursesListNotifier.value;
    });
  }
  

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    // fetchUserName();
    filteredCourses = coursesListNotifier.value;
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UserAppBar(widget: widget),
      body: 
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
               ChatBotBox(widget: widget),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: const Text('All Courses', style: TextStyle(color: Mycolors.black, fontSize: 25, fontWeight: FontWeight.bold)),
                ),
                const Spacer(),
                isSearchActive
                    ? Expanded(
                        flex: 4,
                        child: TextField(
                          controller: searchController,
                          onChanged: searchCourse,
                          style: const TextStyle(color: Mycolors.black),
                          decoration: InputDecoration(
                            hintText: 'Search...',
                            hintStyle: const TextStyle(color: Colors.grey),
                            border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                          ),
                        ),
                      )
                    : IconButton(
                        onPressed: () {
                          setState(() {
                            isSearchActive = true;
                          });
                        },
                        icon: const Icon(Icons.search, size: 30, color: Mycolors.black),
                      ),
                isSearchActive
                    ? IconButton(
                        onPressed: closeSearch,
                        icon: const Icon(Icons.close, size: 30, color: Mycolors.black),
                      )
                    : Container(),
              ],
            ),
            
              CourseGridViewWidget(filteredCourses: filteredCourses, isSearchActive: isSearchActive, userLogindata: widget.userLogindata),
             
            
          ],
        ),
      ),
    );
  }

}


