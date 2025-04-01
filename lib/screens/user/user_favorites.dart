

import 'dart:developer';

import 'package:coursepoint/DataBase/Functions/database_functions.dart'; // Ensure this file exports playListNotifier if used
import 'package:coursepoint/DataBase/Model/courses_model.dart';
import 'package:coursepoint/DataBase/Model/playlist_model.dart';
import 'package:coursepoint/database/model/user_login_model.dart';
import 'package:coursepoint/screens/user/user_course_notes.dart';
import 'package:coursepoint/widget/apppcolor.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

// A ValueNotifier to update the UI when the favorites list changes.
ValueNotifier<List<PlaylistModel>> favoriteNotifier = ValueNotifier([]);

class UserfavoritesScreen extends StatefulWidget {
  const UserfavoritesScreen({super.key, required this.userData,});
  final UserLoginModel userData;
  

  @override
  State<UserfavoritesScreen> createState() => _UserfavoritesScreenState();
}

class _UserfavoritesScreenState extends State<UserfavoritesScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch the current user's favorite playlists when the widget is initialized.
    fetchUserFavoritePlayList();
  }

  
  

Future<void> fetchUserFavoritePlayList() async {
  // Open the user-specific favorites box.
  final userBox = await Hive.openBox('favorites_${widget.userData.id}');
  
  // Retrieve the keys (playlist IDs) stored in the box.
  // Since you're storing the playlist ID as both key and value,
  // you can use userBox.keys.
  List<String> favoritePlaylistIds = userBox.keys.cast<String>().toList();
  
  // log("Favorites for user ${widget.userData.id}: $favoritePlaylistIds");

  // Map the favorite IDs to PlaylistModel objects using your global playlist list.
  List<PlaylistModel> favoritePlaylists = favoritePlaylistIds.map((playlistId) {
    return playListNotifier.value.firstWhere(
      (playlist) => playlist.id == playlistId,
      orElse: () => PlaylistModel(
        playlistVideo: '',
        plalistTitle: 'Unknown Playlist',
        subcourseId: '',
      ),
    );
  }).toList();
  
  favoriteNotifier.value = favoritePlaylists;
  favoriteNotifier.notifyListeners();
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color(0xFF191919),
      appBar: AppBar(
        title:  Text(
          'Favorites',
           style: TextStyle(color: appColorblack, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        // iconTheme: const IconThemeData(color: Colors.grey),
        backgroundColor:  appBarColor,
        
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: favoriteNotifier,
                builder: (context, List<PlaylistModel> favoritePlaylists, child) {
                  return favoritePlaylists.isEmpty
                      ?  Center(
                          child: Text(
                            'Favorite Playlist Not Available',
                            style: TextStyle(color: appColorblack),
                          ),
                        )
                      : ListView.builder(
                          itemCount: favoritePlaylists.length,
                          itemBuilder: (context, index) {
                            final playlistData = favoritePlaylists[index];
                            return Column(
                              children: [
                                GestureDetector(
                                  onTap: () async {
  final courseBox = await Hive.openBox<CoursesModel>('course_db');
  final matchingCourse = courseBox.values.firstWhere(
    (course) => course.id == playlistData.subcourseId,
    orElse: () => CoursesModel(
      image: '',
      coursetitle: 'Unknown Course',
      indroductionvideo: '',
      Description: '',
      id: '',
    ),
  );

  String courseId = matchingCourse.id ?? 'Unknown Course ID';

  await Navigator.of(context).push(
    MaterialPageRoute(
      builder: (ctx) => UsercoursenotesScreen(
        playlistDetails: playlistData,
        userData: widget.userData,
        courseId: courseId,
      ),
    ),
  );

  // Refresh the favorites list after returning
  fetchUserFavoritePlayList();
},


  //                                 onTap: () async{
  //                                   // log("Courses List: ${coursesListNotifier.value}");
  //                                   // log("Looking for course with subcourseId: ${playlistData.subcourseId}");
    
  // // Open the Hive box containing courses
  // final courseBox = await Hive.openBox<CoursesModel>('course_db');

  // // Find the course that matches the subcourseId in playlistData
  // final matchingCourse = courseBox.values.firstWhere(
  //   (course) => course.id == playlistData.subcourseId,  // Match subcourseId with course id
  //   orElse: () => CoursesModel(
  //     image: '',
  //     coursetitle: 'Unknown Course',
  //     indroductionvideo: '',
  //     Description: '',
  //     id: '',  // No matching course found
  //   ),
  // );

  // // Get the courseId
  // String courseId = matchingCourse.id ?? 'Unknown Course ID';

  // print("Navigating with courseId: $courseId");

  // // Navigate to the UsercoursenotesScreen
  // Navigator.of(context).push(
  //   MaterialPageRoute(
  //     builder: (ctx) => UsercoursenotesScreen(
  //       playlistDetails: playlistData,
  //       userData: widget.userData,
  //       courseId: courseId,
  //     ),
  //   ),
  // );



                        
  //                                   // Navigate to the course notes screen and pass the selected playlist and user data.
  //                                   // Navigator.of(context).push(
  //                                   //   MaterialPageRoute(
  //                                   //     builder: (ctx) =>  UsercoursenotesScreen(playlistDetails: playlistData, userData: widget.userData, courseId: );
  //                                   //   ),
  //                                   // );
  //                                 },
                                  
                                  child: Padding(
                                    padding: const EdgeInsets.all(9.0),
                                    child: Container(
                                      height: 70,
                                      decoration:  BoxDecoration(color: Colors.blueGrey.shade100,borderRadius: BorderRadius.circular(10),
                                      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2),spreadRadius: 2,blurRadius: 5,offset: Offset(3, 3))],
                                      ),
                                      child: Row(
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.all(15.0),
                                            child: Icon(Icons.playlist_play),
                                          ),
                                          const SizedBox(width: 80),
                                          Text(
                                            playlistData.plalistTitle,
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                              ],
                            );
                          },
                        );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }


//   @override
// Widget build(BuildContext context) {
//   return WillPopScope(
//     onWillPop: () async {
//       fetchUserFavoritePlayList();
//       return true;
//     },
//     child: Scaffold(
//       appBar: AppBar(
//         title: Text('Favorites',
//           style: TextStyle(color: appColorblack, fontWeight: FontWeight.bold),
//         ),
//         centerTitle: true,
//         backgroundColor: appBarColor,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(30),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Expanded(
//               child: ValueListenableBuilder(
//                 valueListenable: favoriteNotifier,
//                 builder: (context, List<PlaylistModel> favoritePlaylists, child) {
//                   return favoritePlaylists.isEmpty
//                       ? Center(
//                           child: Text(
//                             'Favorite Playlist Not Available',
//                             style: TextStyle(color: appColorblack),
//                           ),
//                         )
//                       : ListView.builder(
//                           itemCount: favoritePlaylists.length,
//                           itemBuilder: (context, index) {
//                             final playlistData = favoritePlaylists[index];
//                             return Column(
//                               children: [
//                                 GestureDetector(
//                                   onTap: () async {
//                                     final courseBox = await Hive.openBox<CoursesModel>('course_db');
//                                     final matchingCourse = courseBox.values.firstWhere(
//                                       (course) => course.id == playlistData.subcourseId,
//                                       orElse: () => CoursesModel(
//                                         image: '',
//                                         coursetitle: 'Unknown Course',
//                                         indroductionvideo: '',
//                                         Description: '',
//                                         id: '',
//                                       ),
//                                     );

//                                     String courseId = matchingCourse.id ?? 'Unknown Course ID';

//                                     await Navigator.of(context).push(
//                                       MaterialPageRoute(
//                                         builder: (ctx) => UsercoursenotesScreen(
//                                           playlistDetails: playlistData,
//                                           userData: widget.userData,
//                                           courseId: courseId,
//                                         ),
//                                       ),
//                                     );

//                                     // Refresh favorites when returning
//                                     fetchUserFavoritePlayList();
//                                   },
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(9.0),
//                                     child: Container(
//                                       height: 70,
//                                       decoration: BoxDecoration(
//                                         color: Colors.blueGrey.shade100,
//                                         borderRadius: BorderRadius.circular(10),
//                                         boxShadow: [
//                                           BoxShadow(
//                                             color: Colors.black.withOpacity(0.2),
//                                             spreadRadius: 2,
//                                             blurRadius: 5,
//                                             offset: Offset(3, 3),
//                                           ),
//                                         ],
//                                       ),
//                                       child: Row(
//                                         children: [
//                                           const Padding(
//                                             padding: EdgeInsets.all(15.0),
//                                             child: Icon(Icons.playlist_play),
//                                           ),
//                                           const SizedBox(width: 80),
//                                           Text(
//                                             playlistData.plalistTitle,
//                                             style: const TextStyle(
//                                               fontSize: 18,
//                                               fontWeight: FontWeight.bold,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 const SizedBox(height: 10),
//                               ],
//                             );
//                           },
//                         );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     ),
//   );
// }

}


