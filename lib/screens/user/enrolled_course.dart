

import 'dart:developer';
import 'dart:io';
import 'package:coursepoint/DataBase/Functions/database_functions.dart';
import 'package:coursepoint/DataBase/Functions/delete_function.dart';
import 'package:coursepoint/DataBase/Model/courses_model.dart';
import 'package:coursepoint/Screens/user/user_course_details.dart';
import 'package:coursepoint/database/functions/favorites_functions.dart';
import 'package:coursepoint/database/model/user_login_model.dart';
import 'package:coursepoint/widget/apppcolor.dart';
import 'package:coursepoint/widget/custom_app_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';


ValueNotifier<List<CoursesModel>> enrolledUserNotifier = ValueNotifier([]);

class EnrolledcourseScreen extends StatefulWidget {
  const EnrolledcourseScreen({super.key, required this.userData});
  final UserLoginModel userData;
  
  @override
  State<EnrolledcourseScreen> createState() => _EnrolledcourseScreenState();
}

class _EnrolledcourseScreenState extends State<EnrolledcourseScreen> {
  @override
  void initState() {
    super.initState();
    var box = Hive.box('userEnrollments');
    
    List<String> enrolledCourseIds = List<String>.from(box.get(widget.userData.id, defaultValue: []));
    
    // Fetch full course details based on IDs
    List<CoursesModel> enrolledCourses = enrolledCourseIds.map((courseId) {
      return coursesListNotifier.value.firstWhere((course) => course.id == courseId, 
        orElse: () => CoursesModel(id: '', coursetitle: '',Description: '',image: '',indroductionvideo: ''));
    }).toList();
    
    
    enrolledUserNotifier.value = enrolledCourses;
    enrolledUserNotifier.notifyListeners(); 
  }

  
  
  


//   Future<void> deleteEnrolledCourse(String courseId, String userId) async {
//   var box = Hive.box('userEnrollments');

//   List<String> enrolledCourseIds = List<String>.from(box.get(userId, defaultValue: []));
//   log('Before deletion: $enrolledCourseIds'); 

//   enrolledCourseIds.remove(courseId);

//   print('After deletion: $enrolledCourseIds'); 

//   box.put(userId, enrolledCourseIds);
//   // removeFavoritePlaylist(userId, playlistId)

//   var box2 = Hive.box('userEnrollments');
  
//   List<String> enrolledCourseIds2 = List<String>.from(box2.get(widget.userData.id, defaultValue: []));
  
//   // Fetch full course details based on IDs
//   List<CoursesModel> enrolledCourses = enrolledCourseIds2.map((courseId) {
//     return coursesListNotifier.value.firstWhere((course) => course.id == courseId, 
//       orElse: () => CoursesModel(id: '', coursetitle: '',Description: '',image: '',indroductionvideo: ''));
//   }).toList();
  
  
//   enrolledUserNotifier.value = enrolledCourses;
//   enrolledUserNotifier.notifyListeners(); 
//   log('Course deleted: $courseId');
// }


  


  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context); 

    return Scaffold(
      // backgroundColor: const Color(0xFF191919),
      // appBar: AppBar(
      //   backgroundColor:  appBarColor,
       
      //   title: Text("Enrolled Courses", style: TextStyle(color: appColorblack, fontWeight: FontWeight.w600)),
      //   centerTitle: true,
      // ),
      appBar: CustomAppBar(title: 'Enrolled Course', backgroundColor: appBarColor, titleColor: appColorblack),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ValueListenableBuilder(
          valueListenable: enrolledUserNotifier,
          builder: (context, List<CoursesModel> enrolledCourses, child) {
            return enrolledCourses.isEmpty
                ?  Center(child: Text('Enrolled Course Not Available', style: TextStyle(color: appColorblack )))
                : ListView.builder(
                    itemCount: enrolledCourses.length,
                    itemBuilder: (context, index) {
                      final courseData = enrolledCourses[index];

                      return GestureDetector(
                        onTap: () {
                          // Navigate to course details screen
                          Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => UsercoursedetailsScreen(courseDetails: courseData, userData: widget.userData)));
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Card(
                            elevation: 10,
                            
                            color: Colors.blueGrey.shade100,
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Container(
                                    width: mediaQuery.size.width * 0.30,
                                    height: 80,
                                    decoration: BoxDecoration( borderRadius: BorderRadius.circular(15),
                                    image:DecorationImage(
                                      image: FileImage(File(courseData.image)),
                                      // image: kIsWeb
                                      // ? NetworkImage(courseData.image)
                                      // : FileImage(File(courseData.image)),
                                    fit: BoxFit.cover) ),
                                  ),
                                ),
                                const SizedBox(width: 20),
                                Text(courseData.coursetitle, style:  TextStyle(color: appColorblack, fontSize: 25, fontWeight: FontWeight.bold)),
                                const Spacer(),
                                IconButton(
                                  onPressed: () {
                                    // Handle delete course logic
                                    // deleteEnrolledCourse(courseData.id!, widget.userData.id!);
                                    showDialog(context: context, builder: (context) {
                                      return AlertDialog(
                                        title: Text('Delete'),
                                        content: Text('Are you sure you want to delete this course?'),
                                        actions: [
                                          TextButton(onPressed: (){
                                            Navigator.pop(context);
                                          }, child: Text('Cancel')),
                                          TextButton(onPressed: (){
                                            deleteEnrolledCourse(courseData.id!, widget.userData.id!);
                                            
                                            Navigator.pop(context);
                                          }, child: Text('Delete')),
                                        ],
                                      );
                                    },);
                                  },
                                  icon:  Icon(Icons.delete, color: appColorblack),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
          },
        ),
      ),
    );
  }
}




