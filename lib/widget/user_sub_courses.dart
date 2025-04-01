
import 'dart:developer';
import 'dart:io';
// import 'dart:math';

import 'package:coursepoint/DataBase/Functions/course_add_functions.dart';
import 'package:coursepoint/DataBase/Functions/database_functions.dart';
import 'package:coursepoint/DataBase/Model/subcourse_model.dart';
import 'package:coursepoint/Screens/user/user_course_details.dart';
import 'package:coursepoint/Screens/user/user_course_playlist.dart';
import 'package:coursepoint/widget/apppcolor.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class UserSubCourses extends StatelessWidget {
  const UserSubCourses({
    super.key,
    required this.widget,
    required this.mediaQuery,
  });

  final UsercoursedetailsScreen widget;
  final MediaQueryData mediaQuery;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: subCourseListNotifier,
      builder: (BuildContext ctx, List<SubcourseModel> subcourseList, Widget? child) {
        
        final filterdList = subcourseList.where((sub){
          if(sub.id != null){
            return sub.courseId== widget.courseDetails.id;
          }
          return false;
        }).toList();
        return ListView.builder(
          shrinkWrap: true,
         physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            // final subCourse = subcourseList[index];
            final subcourseDetails = filterdList[index];
            return 
            GestureDetector(
              onTap: () {
                var box = Hive.box('userEnrollments');
                List<String> enrolledCourses = List<String>.from(box.get(widget.userData.id!, defaultValue: []));
                
                if (enrolledCourses.contains(widget.courseDetails.id!)) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => UsercourseplaylistScreen(courseId: widget.courseDetails.id!, subcourse: subcourseDetails, userData: widget.userData, totalSubCourses: filterdList.length)));
                } else {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Enroll Now'),
                      content: Text('You need to enroll in this course to access the sub-course.'),
                      actions: [
                        TextButton(onPressed: () {
                          Navigator.pop(context);
                        }, child: Text('Cancel')),
                        TextButton(
                          onPressed: () {
                            enrollUser(widget.userData.id!, widget.courseDetails.id!, widget.userData.name, widget.courseDetails.coursetitle);
                            Navigator.pop(context);
                          },
                          child: Text('Enroll Now'),
                        ),
                      ],
                    ),
                  );
                }
                log("${filterdList.length}");
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height:90,
                 decoration:  BoxDecoration(color: Colors.blueGrey.shade100,borderRadius: BorderRadius.circular(10),
                      boxShadow: [BoxShadow( color: Colors.black.withOpacity(0.2), spreadRadius: 2, blurRadius: 5,offset: Offset(3, 3))] ),
                  padding: EdgeInsets.only(left: 10, right: 10), // Adjust padding for spacing
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center, // Align items at the top
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Leading Image
                      Container(
                        width: mediaQuery.size.width * 0.30, // Increase width
                        height: 70, // Increase height
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            // image: FileImage(File(subcourseDetails.subcourseimage)),
                            image: kIsWeb
                            ? NetworkImage(subcourseDetails.subcourseimage)
                            : FileImage(File(subcourseDetails.subcourseimage)),
                            fit: BoxFit.cover,
                          ),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      SizedBox(width: 16), // Space between image and text
                      // Title Text
                      Expanded(
                        child: Text(
                          subcourseDetails.subcoursetitle,
                          style: TextStyle(
                            color: appColorblack,
                            fontSize: 24, // Increased font size
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
    
           
          },
         
          itemCount: filterdList.length,
        );
      },
    );
  }
}