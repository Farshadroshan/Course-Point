
// import 'dart:developer';

// import 'package:hive_flutter/hive_flutter.dart';

// void addFavoritePlaylist (String userId , String playlistId) {
//   var box = Hive.box('favorites');

//   List<String> favoriteCourse = List<String>.from(box.get(userId, defaultValue: []));

//   if(!favoriteCourse.contains(playlistId)){
//     favoriteCourse.add(playlistId);
//     box.put(userId, favoriteCourse);
//   }
//   log('favorite playlist : ${playlistId}');
//   log('user id : ${userId}');
// }


// import 'dart:developer';

// import 'package:hive_flutter/hive_flutter.dart';

// final Box favoriteBox = Hive.box('favorites');

// // Returns a Future<bool> indicating if the playlist is a favorite.
// Future<bool> isFavoritePlaylist(String userId, String playlistId) async {
//   final userBox = await Hive.openBox('favorites_$userId');
//   return userBox.containsKey(playlistId);

// }

// Future<void> addFavoritePlaylist(String userId, String playlistId) async {
//   final userBox = await Hive.openBox('favorites_$userId');
//   // Here you can store either the id or the entire playlist object.
//   await userBox.put(playlistId, playlistId);
//   log('add favorite : ${playlistId}');
// }

// Future<void> removeFavoritePlaylist(String userId, String playlistId) async {
//   final userBox = await Hive.openBox('favorites_$userId');
//   await userBox.delete(playlistId);
//   log('remove favorite : ${playlistId}');
// }



import 'dart:developer';

import 'package:hive_flutter/hive_flutter.dart';

final Box favoriteBox = Hive.box('favorites');

// Returns a Future<bool> indicating if the playlist is a favorite.
Future<bool> isFavoritePlaylist(String userId, String playlistId) async {
  final userBox = await Hive.openBox('favorites_$userId');
  return userBox.containsKey(playlistId);
}

Future<void> addFavoritePlaylist(String userId, String playlistId) async {
  final userBox = await Hive.openBox('favorites_$userId');
  // Here you can store either the id or the entire playlist object.
  await userBox.put(playlistId, playlistId);
  log('playlist added');
}

Future<void> removeFavoritePlaylist(String userId, String playlistId) async {
  final userBox = await Hive.openBox('favorites_$userId');
  await userBox.delete(playlistId);
  log('playlist removed');
}
