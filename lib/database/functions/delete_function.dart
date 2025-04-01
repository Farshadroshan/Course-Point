
import 'dart:developer';

import 'package:coursepoint/DataBase/Functions/database_functions.dart';
import 'package:coursepoint/DataBase/Model/courses_model.dart';
import 'package:coursepoint/DataBase/Model/note_model.dart';
import 'package:coursepoint/DataBase/Model/playlist_model.dart';
import 'package:coursepoint/DataBase/Model/subcourse_model.dart';
import 'package:coursepoint/Screens/user/enrolled_course.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future <void> deleteCourse(String id)async{
  final courseDB = await Hive.openBox<CoursesModel>('course_db');
  await courseDB.delete(id);
  coursesListNotifier.notifyListeners();
  fechingCourseDetails();
}

Future <void> deleteSubCourse(String id) async{
  final subcoursDb = await Hive.openBox<SubcourseModel>('SubCourse_Db');
  await subcoursDb.delete(id);
  subCourseListNotifier.notifyListeners;
  fechingSubCourseDetails();
}

Future <void> deletePlayList(String id) async {
  final PlayListDb = await Hive.openBox<PlaylistModel>('PlayList_Db');
  await PlayListDb.delete(id);
  playListNotifier.notifyListeners();
  fechingPlayListDetails();
}

Future <void> deletenote(String id) async{
  final noteDb = await Hive.openBox<NoteModel>('Note_Db');
  await noteDb.delete(id);

  noteListNotifier.notifyListeners();
  fechingNoteDetails();
}


 Future<void> deleteEnrolledCourse(String courseId, String userId) async {
  var box = Hive.box('userEnrollments');

  List<String> enrolledCourseIds = List<String>.from(box.get(userId, defaultValue: []));
  log('Before deletion: $enrolledCourseIds'); 

  enrolledCourseIds.remove(courseId);

  print('After deletion: $enrolledCourseIds'); 

  box.put(userId, enrolledCourseIds);
  // removeFavoritePlaylist(userId, playlistId)

  var box2 = Hive.box('userEnrollments');
  
  List<String> enrolledCourseIds2 = List<String>.from(box2.get(userId, defaultValue: []));
  
  // Fetch full course details based on IDs
  List<CoursesModel> enrolledCourses = enrolledCourseIds2.map((courseId) {
    return coursesListNotifier.value.firstWhere((course) => course.id == courseId, 
      orElse: () => CoursesModel(id: '', coursetitle: '',Description: '',image: '',indroductionvideo: ''));
  }).toList();
  
  
  enrolledUserNotifier.value = enrolledCourses;
  enrolledUserNotifier.notifyListeners(); 
  log('Course deleted: $courseId');
}


