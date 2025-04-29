import 'dart:developer';

import 'package:coursepoint/DataBase/Functions/database_functions.dart';
import 'package:coursepoint/DataBase/Model/courses_model.dart';
import 'package:coursepoint/DataBase/Model/playlist_model.dart';
import 'package:coursepoint/DataBase/Model/subcourse_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> updateCourse(CoursesModel courseDetails) async {
    final courseDb = await Hive.openBox<CoursesModel>('course_db');
    
    log(courseDetails.id??'id isnull');
    log(courseDetails.coursetitle);
    await courseDb.put(courseDetails.id, courseDetails);
    coursesListNotifier.notifyListeners();
      fechingCourseDetails();
  }


Future<void> updateSubCourse(SubcourseModel subcourseDetails)async{

  final SubCouseDb = await Hive.openBox<SubcourseModel>('SubCourse_Db');

  await SubCouseDb.put(subcourseDetails.id, subcourseDetails );
  subCourseListNotifier.notifyListeners();
  fechingSubCourseDetails();
}
  

  Future <void> updatePlaylist(PlaylistModel playlistDetails)async{
    final PlaylistDb = await Hive.openBox<PlaylistModel>('PlayList_Db');
    await PlaylistDb.put(playlistDetails.id, playlistDetails);
    playListNotifier.notifyListeners();
    fechingPlayListDetails();
  }

