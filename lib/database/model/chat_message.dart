import 'package:hive_flutter/hive_flutter.dart';

part 'chat_message.g.dart';

@HiveType(typeId: 8)
class ChatMessage extends HiveObject{


  @HiveField(0)
  String role;

  @HiveField(1)
  String text;

  @HiveField(2)
  final DateTime ? timestamp;

  ChatMessage({required this.role , required this.text, this.timestamp});
 
}