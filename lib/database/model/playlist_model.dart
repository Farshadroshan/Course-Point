

import 'package:hive_flutter/hive_flutter.dart';
part 'playlist_model.g.dart';

@HiveType(typeId: 4)
class PlaylistModel extends HiveObject{


@HiveField(0)
final String playlistVideo;
@HiveField(1)
final String plalistTitle;
@HiveField(2)
String? id;
@HiveField(3)
String subcourseId;

PlaylistModel({required this.playlistVideo,required this.plalistTitle, this.id, required this.subcourseId});
}

