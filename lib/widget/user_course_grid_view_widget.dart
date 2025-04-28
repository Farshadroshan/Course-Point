import 'dart:convert';
import 'dart:io';
import 'package:coursepoint/DataBase/Functions/database_functions.dart';
import 'package:coursepoint/DataBase/Model/courses_model.dart';
import 'package:coursepoint/Screens/user/user_course_details.dart';
// import 'package:coursepoint/Screens/user/user_menu.dart';
import 'package:coursepoint/database/model/user_login_model.dart';
// import 'package:coursepoint/screens/user/user_chatbot_page.dart';
import 'package:coursepoint/widget/apppcolor.dart';
// import 'package:coursepoint/widget/chat_bot_button_widget.dart';
// import 'package:coursepoint/widget/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CourseGridViewWidget extends StatelessWidget {
  final List<CoursesModel> filteredCourses;
  final bool isSearchActive;
  final UserLoginModel userLogindata;

  const CourseGridViewWidget({
    Key? key,
    required this.filteredCourses,
    required this.isSearchActive,
    required this.userLogindata,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ValueListenableBuilder(
        valueListenable: coursesListNotifier,
        builder: (BuildContext ctx, List<CoursesModel> courseList, Widget? child) {
          final displayList = isSearchActive ? filteredCourses : courseList;

          if (courseList.isEmpty) {
            return Center(
              child: Text(
                'Course Not Available',
                style: TextStyle(color: appColorblack),
              ),
            );
          }

          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 4,
              mainAxisSpacing: 4,
              mainAxisExtent: 210,
            ),
            itemCount: displayList.length,
            itemBuilder: (ctx, index) {
              final courseUser = displayList[index];
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (ctx) => UsercoursedetailsScreen(
                          courseDetails: courseUser,
                          userData: userLogindata)));
                },
                child: Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  color: appBarColor,
                  child: Column(
                    children: [
                      ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(12.0),
                            topRight: Radius.circular(12.0),
                          ),
                          child: _buildCourseImage(courseUser.image)),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                courseUser.coursetitle,
                                style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.white54,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(Icons.arrow_forward_ios,
                                  size: 16, color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildCourseImage(String imageSource) {
    if (imageSource.startsWith('BASE64:')) {
      try {
        final base64Data = imageSource.substring(7);
        return Image.memory(
          base64Decode(base64Data),
          height: 130,
          width: double.infinity,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return _buildErrorPlaceholder();
          },
        );
      } catch (e) {
        return _buildErrorPlaceholder();
      }
    } else {
      if (kIsWeb) {
        return _buildErrorPlaceholder();
      } else {
        try {
          return Image.file(
            File(imageSource),
            height: 130,
            width: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return _buildErrorPlaceholder();
            },
          );
        } catch (e) {
          return _buildErrorPlaceholder();
        }
      }
    }
  }

  Widget _buildErrorPlaceholder() {
    return Container(
      height: 130,
      width: double.infinity,
      color: Colors.grey[300],
      child: const Center(
        child: Icon(Icons.image_not_supported, size: 40, color: Colors.grey),
      ),
    );
  }
}
