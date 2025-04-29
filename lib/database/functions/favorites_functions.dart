

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
