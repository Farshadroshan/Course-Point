

import 'dart:developer';

import 'package:coursepoint/database/model/progress_model.dart';
import 'package:hive_flutter/hive_flutter.dart';



 void onComplete(String userId, String courseId, String subCourseId,int totalSubCourses ) async {
  var box = Hive.box<ProgressModel>('progressBox');

  // Try to find existing progress
  ProgressModel? progress;
  for (var item in box.values) {
    if (item.userId == userId && item.courseId == courseId) {
      progress = item;
      break;
    }
  }

  // If progress is found and subCourseId is not already completed
  if (progress != null) {
    if (!progress.completedSubCourses.contains(subCourseId)) {
      progress.completedSubCourses.add(subCourseId);
      await progress.save(); // Save the updated progress
    }
  } else {
    // If no existing progress, create and add a new one
    var newProgress = ProgressModel(
      userId: userId,
      courseId: courseId,
      completedSubCourses: [subCourseId],
      totalSubCourses: totalSubCourses,
    );
    await box.add(newProgress); // Add the new object to the box
  }
}

Future<void> deleteProgress(String courseId) async {
  var box = Hive.box<ProgressModel>('progress');
  var progress = box.values.firstWhere((item) => item.courseId == courseId);
  progress.delete();
}

