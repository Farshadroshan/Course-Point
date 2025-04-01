// import 'package:hive/hive.dart';

// part 'progress_model.g.dart'; 

// @HiveType(typeId: 1)
// class ProgressModel extends HiveObject {
//   @HiveField(0)
//   String courseId;

//   @HiveField(1)
//   int completedPlayList;

//   @HiveField(2)
//   int totalPlayList;

//   ProgressModel({
//     required this.courseId,
//     required this.completedPlayList,
//     required this.totalPlayList,
//   });
// }







// @HiveType(typeId: 0)
// class UserProgress {
//   @HiveField(0)
//   final String courseId; // e.g. "1489076352"

//   @HiveField(1)
//   int progressPoint; // how many playlists completed

//   @HiveField(2)
//   int totalPoint; // total playlists in the course

//   UserProgress(this.courseId, this.progressPoint, this.totalPoint);

//   @override
//   String toString() =>
//       'UserProgress(courseId: $courseId, progressPoint: $progressPoint, totalPoint: $totalPoint)';
// }

// @HiveType(typeId: 0)
// class UserProgress {
//   @HiveField(0)
//   String courseId;

//   @HiveField(1)
//   int progressPoint;

//   @HiveField(2)
//   int totalPoint;

//   UserProgress(this.courseId, this.progressPoint, this.totalPoint);
// }

import 'package:hive_flutter/hive_flutter.dart';
part 'progress_model.g.dart';

///////////////////////////////////////////////////////////




// @HiveType(typeId: 0)
// class UserProgress extends HiveObject {
//   @HiveField(0)
//   final String courseId; // Changed to String

//   @HiveField(1)
//   int progressPoint; // Number of completed playlists

//   @HiveField(2)
//   int totalPoint; // Total playlists in the course

//   @HiveField(3)
//   List<String> completedPlaylists; // Changed to List<String>

//   UserProgress(this.courseId, this.progressPoint, this.totalPoint, {List<String>? completedPlaylists})
//       : completedPlaylists = completedPlaylists ?? [];

//   @override
//   String toString() {
//     return 'UserProgress(courseId: $courseId, progressPoint: $progressPoint, totalPoint: $totalPoint, completedPlaylists: $completedPlaylists)';
//   }
// }


// @HiveType(typeId: 0)
// class UserProgress {
//   @HiveField(0)
//   String courseId;

//   @HiveField(1)
//   int progressPoint;

//   @HiveField(2)
//   int totalPoint;

//   UserProgress(this.courseId, this.progressPoint, this.totalPoint);
// }

////////////////////////////////////



// @HiveType(typeId: 0)
// class ProgressModel extends HiveObject {
//   @HiveField(0)
//   final String userId;

//   @HiveField(1)
//   final String courseId;

//   @HiveField(2)
//   final int totalSubCourses;

//   @HiveField(3)
//   int completedSubCourses;

//   ProgressModel({
//     required this.userId,
//     required this.courseId,
//     required this.totalSubCourses,
//     this.completedSubCourses = 0,
//   });
// }



@HiveType(typeId: 0)
class ProgressModel extends HiveObject {
  @HiveField(0)
  String userId;

  @HiveField(1)
  String courseId;

  @HiveField(2)
  List<String> completedSubCourses;

  @HiveField(3)
  int totalSubCourses;

  ProgressModel({
    required this.userId,
    required this.courseId,
    required this.completedSubCourses,
    required this.totalSubCourses,
  });
}