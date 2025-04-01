

import 'package:hive_flutter/hive_flutter.dart';
part 'courses_model.g.dart';

@HiveType(typeId: 2)
class CoursesModel extends HiveObject{

  @HiveField(0)
  final String image;
  @HiveField(1)
  final String coursetitle;
  @HiveField(2)
  final  String indroductionvideo;
  @HiveField(3)
  final String Description;
  @HiveField(4)
  String? id;
  CoursesModel({required this.image,required this.coursetitle, required this.indroductionvideo,required this.Description, this.id, });

}


