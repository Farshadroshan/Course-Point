
import 'package:hive_flutter/hive_flutter.dart';
part 'note_model.g.dart';
@HiveType(typeId: 5)
class NoteModel extends HiveObject{
  @HiveField(0)
  final String notequestion;
  @HiveField(1)
  final String noteAnswer;
  @HiveField(2)
  String? id;
  @HiveField(3)
  String playlistId;

  NoteModel({required this.notequestion,required this.noteAnswer,required this.playlistId});
}