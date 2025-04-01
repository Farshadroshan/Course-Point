// import 'package:coursepoint/database/model/progress_model.dart';
// import 'package:hive_flutter/hive_flutter.dart';

// void updateProgress(String courseId) {
//   final progressBox = Hive.box<ProgressModel>('progressBox');
  
//   ProgressModel? progress = progressBox.get(courseId);

//   if (progress != null && progress.completedPlayList < progress.totalPlayList) {
//     progress.completedPlayList += 1;
//     progress.save(); // Save changes
//   } else {
//     // If the course is not found, add a new entry
//     progressBox.put(
//       courseId,
//       ProgressModel(courseId: courseId, completedPlayList: 1, totalPlayList: 3),
//     );
//   }

//   setState(() {}); // Refresh UI
// }



// import 'package:coursepoint/database/model/progress_model.dart';
// import 'package:flutter/material.dart';
// import 'package:hive_flutter/hive_flutter.dart';

import 'dart:developer';

import 'package:coursepoint/database/model/progress_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

///////////////////////////////////////////////////

// import 'package:coursepoint/database/Model/progress_model.dart';
// import 'package:flutter/material.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'dart:developer';
// import 'package:hive_flutter/hive_flutter.dart';
// // import 'package:learncode/models/user_progress.dart';

// ValueNotifier<List<UserProgress>> progressNotifier = ValueNotifier([]);

// // **Add a new course progress**
// Future<void> addCourseProgress(String courseId, int totalPlaylists) async {
//   final progressBox = await Hive.openBox<UserProgress>('userProgress');
  
//   if (progressBox.values.any((p) => p.courseId == courseId)) {
//     log('Course $courseId already exists in progress.');
//     return;
//   }

//   final progress = UserProgress(courseId, 1, totalPlaylists);
//   await progressBox.add(progress);
//   log('Progress added: $progress');
//   updateProgressNotifier();
// }


// // Future<void> addCourseProgress(String userId, String courseId, int totalPlaylists) async {
// //   final progressBox = await Hive.openBox<UserProgress>('userProgress');
  
// //   if (progressBox.values.any((p) => p.userId == userId && p.courseId == courseId)) {
// //     log('Course $courseId already exists for user $userId.');
// //     return;
// //   }

// //   final progress = UserProgress(userId, courseId, 0, totalPlaylists);
// //   await progressBox.add(progress);
// //   log('Progress added for user $userId: $progress');
// //   updateProgressNotifier(userId); // 👈 Pass userId here
// // }




// // **Add a new course progress for a specific user**





// Future<void> completePlaylist(String courseId, String playlistId) async {
//   final progressBox = await Hive.openBox<UserProgress>('userProgress');

//   final index = progressBox.values.toList().indexWhere((p) => p.courseId == courseId);
  
//   //  If course not found, add it first
//   if (index == -1) {
//     log('Course $courseId not found, adding new course entry.');
//     await addCourseProgress(courseId, 1); // Add course with 1 total playlist
//     return; // Retry completing the playlist after adding
//   }

//   final progress = progressBox.getAt(index);

//   if (progress!.completedPlaylists.contains(playlistId)) {
//     log('Playlist $playlistId already completed for course $courseId');
//     return;
//   }

//   progress.completedPlaylists.add(playlistId);
//   progress.progressPoint++;

//   await progressBox.putAt(index, progress);
//   log('Playlist $playlistId marked as completed for course $courseId');
//   updateProgressNotifier();
// }






// // **Get all user progress**
// Future<void> loadUserProgress() async {
//   final progressBox = await Hive.openBox<UserProgress>('userProgress');
//   progressNotifier.value = progressBox.values.toList();
//   progressNotifier.notifyListeners();
// }



// // **Calculate overall progress percentage**
// double calculateProgress(String courseId) {
//   final progressBox = Hive.box<UserProgress>('userProgress');
//   final progress = progressBox.values.firstWhere((p) => p.courseId == courseId, orElse: () => UserProgress(courseId, 0, 1));

//   if (progress.totalPoint == 0) return 0;
//   return (progress.progressPoint / progress.totalPoint) * 100;
// }





// // **Notify UI when progress updates**
// void updateProgressNotifier() {
//   final progressBox = Hive.box<UserProgress>('userProgress');
//   progressNotifier.value = progressBox.values.toList();
//   progressNotifier.notifyListeners();
// }






// //////////////////////////////////////////////////////////////////////////



// import 'package:hive/hive.dart';
// import '../model/progress_model.dart';

// // Update progress for a user
// Future<void> updateUserProgress(String userId, String playlistId) async {
//   final progressBox = await Hive.openBox<ProgressModel>('progress');

//   // Check if progress exists for this user and playlist
//   var progressList = progressBox.values.where((progress) =>
//       progress.userId == userId &&
//       progress.playlistId == playlistId).toList();

//   if (progressList.isNotEmpty) {
//     // Progress exists, update it
//     final progress = progressList.first;
//     progress.completed = true;
//     await progressBox.put(progress.id, progress);
//   } else {
//     // No progress found, add new progress entry
//     final newProgress = ProgressModel(
//       id: DateTime.now().millisecondsSinceEpoch.toString(),
//       userId: userId,
//       playlistId: playlistId,
//       completed: true,
//     );
//     await progressBox.put(newProgress.id, newProgress);
//   }
// }

// // Get user progress
// Future<List<ProgressModel>> getUserProgress(String userId) async {
//   final progressBox = await Hive.openBox<ProgressModel>('progress');

//   return progressBox.values.where((progress) =>
//       progress.userId == userId).toList();
// }



// void markSubCourseComplete(String userId, String subCourseId) {
//   var box = Hive.box<UserProgress>('userProgress');
//   var progress = box.values.firstWhere(
//     (element) => element.userId == userId && element.subCourseId == subCourseId,
//     orElse: () => UserProgress(userId: userId, subCourseId: subCourseId),
//   );

//   progress.isCompleted = true;
//   box.put(progress.key, progress);
// }
////////////////////////////////////////////////////////////////////////////////////////////
// Future<void> markSubCourseComplete(String userId, String subCourseId) async {
//   // Get the already opened box
//   var box ;
// if (box.isOpen('userprogress')) {
//   box = Hive.box<UserProgress>('userprogress');
// }else{
//   box = await Hive.openBox<UserProgress>('userprogress');
// }
//   var progress = box.values.firstWhere(
//     (element) => element.userId == userId && element.subCourseId == subCourseId,
//     orElse: () => UserProgress(userId: userId, subCourseId: subCourseId),
//   );

//   progress.isCompleted = true;
//   box.put(progress.key, progress);
// }


// double calculateProgress(String courseId, String userId, List<String> subCourseIds) {
//   var box = Hive.box<UserProgress>('userprogress');
//   var total = subCourseIds.length;
//   var completed = box.values.where((element) =>
//       element.userId == userId &&
//       subCourseIds.contains(element.subCourseId) &&
//       element.isCompleted).length;
 
//   if (total == 0) return 0;
//   return (completed / total) * 100;
// }


// Widget buildProgressBar(double progress) {
//   return LinearProgressIndicator(
//     value: progress / 100,
//     minHeight: 10,
//     backgroundColor: Colors.grey[300],
//     valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
//   );
// }




// Future<void> addProgress(String userId, String courseId, int totalSubCourses) async {
//   var box = Hive.box<ProgressModel>('progress');
//   box.add(ProgressModel(
//     userId: userId, 
//     courseId: courseId,
//     totalSubCourses: totalSubCourses,
//     completedSubCourses: 0,
//   ));
//   log('userid add in progress $userId');
//   log('courseid add in prog ${courseId}');
//   log('total sub course ${totalSubCourses}');
// }


// Future<void> markSubCourseAsComplete(String userId, String courseId, int totalSubCourses) async {
//   var box = Hive.box<ProgressModel>('progress');

//   // Check if progress exists for this user and course
//   var existingProgress = box.values.firstWhere(
//     (item) => item.userId == userId && item.courseId == courseId,
//     orElse: () => ProgressModel(
//       userId: userId,
//       courseId: courseId,
//       totalSubCourses: totalSubCourses,
//       completedSubCourses: 0
//     ) // Return a default ProgressModel
//   );

//   // Check if it's a new progress entry
//   if (existingProgress.completedSubCourses == 0) {
//     // Add a new entry because it doesn't exist
//     box.add(existingProgress..completedSubCourses = 1);
//   } else {
//     // If it exists, update completed sub-courses
//     existingProgress.completedSubCourses++;
//     existingProgress.save();
//   }
// }


// void onComplete(String userId, String courseId, String subCourseId) {
//   var box = Hive.box<ProgressModel>('progress');
//   var progress = box.values.firstWhere(
//     (item) => item.userId == userId && item.courseId == courseId,
//     orElse: () => ProgressModel(
//       userId: userId,
//       courseId: courseId,
//       totalSubCourses: 0,
//       completedSubCourses: 0,
//       completedSubCourseIds: []
//     )
//   );

//   // Check if this sub-course is already completed
//   if (!progress.completedSubCourseIds.contains(subCourseId)) {
//     // If not, add the sub-course ID to the list
//     progress.completedSubCourseIds.add(subCourseId);
//     progress.completedSubCourses++;  // Increase the completed count
//     progress.save();  // Save the changes
//   }
// }

// void onComplete(String userId, String courseId, String subCourseId) async {
//   var box = Hive.box<ProgressModel>('progressBox');
//   ProgressModel? progress = box.values.firstWhere(
//   (element) => element.userId == userId && element.courseId == courseId,
//   orElse: () => null,
// );


//   // if (progress != null) {
//   //   // Check if the sub-course is already marked as complete
//   //   if (!progress.completedSubCourses.contains(subCourseId)) {
//   //     progress.completedSubCourses.add(subCourseId);
//   //     await progress.save(); // Save the updated progress
//   //   }
//   // } 
//   if (progress != null && !progress.completedSubCourses.contains(subCourseId)) {
//   progress.completedSubCourses.add(subCourseId);
//   await progress.save(); // Save the updated progress
// }

//   else {
//     // If no progress is found, create a new one
//     var newProgress = ProgressModel(
//       userId: userId,
//       courseId: courseId,
//       completedSubCourses: [subCourseId],
//       totalSubCourses: 0, // Set this to the actual total if you have it
//     );
//     await box.add(newProgress); // Add the new object to the box
//   }
// }

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




// Future<void> markSubCourseAsComplete(String userId, String courseId) async {
//   var box = Hive.box<ProgressModel>('progress');
  
//   var progress = box.values.firstWhere(
//     (item) => item.userId == userId && item.courseId == courseId,
//     orElse: () => ProgressModel(userId: userId, courseId: courseId, totalSubCourses: 1, completedSubCourses: 0)
//   );

//   progress.completedSubCourses++;
//   progress.save();
// }

// double calculateProgress(String courseId) {
//   var box = Hive.box<ProgressModel>('progress');
//   var progress = box.values.firstWhere((item) => item.courseId == courseId);

//   if (progress.totalSubCourses == 0) return 0.0;
//   return progress.completedSubCourses / progress.totalSubCourses;
// }

// double calculateUserProgress(String userId, String courseId) {
//   var box = Hive.box<ProgressModel>('progress');
//   var progress = box.values.firstWhere(
//     (item) => item.userId == userId && item.courseId == courseId,
//     orElse: () => ProgressModel(
//       userId: userId,
//       courseId: courseId,
//       totalSubCourses: 0,
//       completedSubCourses: 0
//     )
//   );

//   if (progress.totalSubCourses == 0) return 0.0;
//   return progress.completedSubCourses / progress.totalSubCourses;
// }




Future<void> deleteProgress(String courseId) async {
  var box = Hive.box<ProgressModel>('progress');
  var progress = box.values.firstWhere((item) => item.courseId == courseId);
  progress.delete();
}

