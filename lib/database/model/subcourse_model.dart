

import 'package:hive_flutter/hive_flutter.dart';
part 'subcourse_model.g.dart';

@HiveType(typeId: 3)
class SubcourseModel extends HiveObject{
  
  @HiveField(0)
  final String subcourseimage;
  @HiveField(1)
  final String subcoursetitle;
  @HiveField(2)
  String? id;
  @HiveField(3)
  String courseId;
  
  SubcourseModel({
    required this.subcourseimage,
    required this.subcoursetitle, 
    this.id,
     required this.courseId,
    });
}