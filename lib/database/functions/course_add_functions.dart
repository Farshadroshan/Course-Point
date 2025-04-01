
import 'dart:developer';

import 'package:coursepoint/DataBase/Functions/create_Id.dart';
import 'package:coursepoint/DataBase/Functions/database_functions.dart';
import 'package:coursepoint/DataBase/Model/courses_model.dart';
import 'package:coursepoint/DataBase/Model/note_model.dart';
import 'package:coursepoint/DataBase/Model/playlist_model.dart';
import 'package:coursepoint/DataBase/Model/subcourse_model.dart';
import 'package:coursepoint/database/model/user_details_model.dart';
import 'package:coursepoint/database/model/user_login_model.dart';
import 'package:hive_flutter/hive_flutter.dart';



//course add function

Future<void> addCourse(CoursesModel value) async {
  final CourseDB = await Hive.openBox<CoursesModel>('Course_db');
  String id = createCustomId();
  value.id = id;
  await CourseDB.put(id, value);
  coursesListNotifier.value = CourseDB.values.toList();
  log('course $id');
  log('values${value.id}');
} 

// Future<void> addCourse(CoursesModel value) async {
//   final courseDB = Hive.box<CoursesModel>('course_db'); // Use box directly
//   String id = createCustomId();
//   value.id = id;
//   await courseDB.put(id, value);
//   coursesListNotifier.value = courseDB.values.toList();
//   log('course $id');
//   log('values${value.id}');
// }



//subcourse add function
Future <void> AddSubCourse(SubcourseModel value) async{
  final SubCourseDb = await Hive.openBox<SubcourseModel>('SubCourse_Db');
  String id = createCustomId();
  value.id = id;
  await SubCourseDb.put(id, value);
  subCourseListNotifier.value = SubCourseDb.values.toList();
  subCourseListNotifier.notifyListeners();
  // print('course= ${value.courseId}');
  // print('subcourse = ${value.id}');
}
//playlist add function
Future<void> addPlayList(PlaylistModel value) async{
  final PlayListDb = await Hive.openBox<PlaylistModel>('PlayList_Db');
  String id = createCustomId();
  value.id = id;
  await PlayListDb.put(id, value);
  playListNotifier.value = PlayListDb.values.toList();
  playListNotifier.notifyListeners();
  // print('subcourse: ${value.subcourseId}');
   log('playList: ${value.id}');
}

//notes add function
Future<void>addnotes(NoteModel value)async{
  final noteDb = await Hive.openBox<NoteModel>('Note_Db');
  String id = createCustomId();
  value.id =id;
  // log('Noter id created : ${value.id}');
  await noteDb.put(id, value);
  noteListNotifier.value = noteDb.values.toList();
  playListNotifier.notifyListeners();
}

Future <void> userDetails(UserDetailsModel value)async{
  final userDetails = await Hive.openBox<UserDetailsModel>('userDetails');
  await userDetails.put(value.userid, value);
  log(value.name);
  log(value.userid);
}




void enrollUser(String userId, String courseId, String userName, String courseTitle) {
  var box = Hive.box('userEnrollments');

  // Store user enrollments
  List<String> enrolledCourses = List<String>.from(box.get(userId, defaultValue: []));
  if (!enrolledCourses.contains(courseId)) {
    enrolledCourses.add(courseId);
    box.put(userId, enrolledCourses);
  }

  // Store admin enroll details
  var adminBox = Hive.box('adminEnrollments');
  
  // 🔹 Convert each entry to `Map<String, String>` explicitly
  List<Map<String, String>> enrollments = [];
  var storedData = adminBox.get('enrollments', defaultValue: []);

  if (storedData is List) {
    try {
      enrollments = storedData.map((e) => Map<String, String>.from(e)).toList();
    } catch (e) {
      print("Error converting stored enrollments: $e");
      enrollments = [];
    }
  }

  // Check if the user is already enrolled in this course
  bool alreadyEnrolled = enrollments.any((entry) => entry['userId'] == userId && entry['courseId'] == courseId);

  if (!alreadyEnrolled) {
    enrollments.add({
      'userId': userId,
      'userName': userName,
      'courseId': courseId,
      'courseTitle': courseTitle,
    });
    adminBox.put('enrollments', enrollments);
  }

  log('User enrolled successfully');
  log('User ID: ${box.get(userId)}');
}



