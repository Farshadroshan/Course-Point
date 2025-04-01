



import 'package:coursepoint/DataBase/Model/courses_model.dart';
import 'package:coursepoint/DataBase/Model/note_model.dart';
import 'package:coursepoint/DataBase/Model/playlist_model.dart';
import 'package:coursepoint/DataBase/Model/subcourse_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

ValueNotifier<List<CoursesModel>> coursesListNotifier=ValueNotifier([]);
ValueNotifier<List<SubcourseModel>> subCourseListNotifier = ValueNotifier([]);
ValueNotifier<List<PlaylistModel>>playListNotifier=ValueNotifier([]);
ValueNotifier<List<NoteModel>>noteListNotifier = ValueNotifier([]);







// Future<void> fetchAllCourses() async {
//   final CourseDB = await Hive.openBox<CoursesModel>('Course_db');
//   // final List<CoursesModel> courseList = CourseDB.values.toList();

//   coursesListNotifier.value = CourseDB.values.toList();
//   coursesListNotifier.notifyListeners();

//    final SubCourseDb = await Hive.openBox<SubcourseModel>('SubCourse_Db');
//    final List<SubcourseModel> subcourseList = SubCourseDb.values.toList();
//    subCourseListNotifier.value=subcourseList;
//    subCourseListNotifier.notifyListeners();

//    final PlayListDb = await Hive.openBox<PlaylistModel>('PlayList_Db');
//    final List<PlaylistModel> PlayList = PlayListDb.values.toList();
//    playListNotifier.value= PlayList; 
//    playListNotifier.notifyListeners();

//    final NoteDb = await Hive.openBox<NoteModel>('Note_Db');
//    final List<NoteModel> noteList = NoteDb.values.toList();
//    noteListNotifier.value = noteList;
//    noteListNotifier.notifyListeners();
// }

Future <void> fechingCourseDetails()async{
  final courseDb = await Hive.openBox<CoursesModel>('course_db');
  coursesListNotifier.value = courseDb.values.toList();

  // log(coursesListNotifier.value.first.coursetitle);

  coursesListNotifier.notifyListeners();
} 

Future <void> fechingSubCourseDetails() async{
  final SubCourseDb = await Hive.openBox<SubcourseModel>('SubCourse_Db');
  subCourseListNotifier.value = SubCourseDb.values.toList();
  subCourseListNotifier.notifyListeners();
}

Future <void> fechingPlayListDetails() async{
  final PlayListDb = await Hive.openBox<PlaylistModel>('PlayList_Db');
  playListNotifier.value = PlayListDb.values.toList();
  playListNotifier.notifyListeners();
}

Future <void> fechingNoteDetails() async{
  final noteDb = await Hive.openBox<NoteModel>('Note_Db');
  noteListNotifier.value = noteDb.values.toList();
  noteListNotifier.notifyListeners();
}




