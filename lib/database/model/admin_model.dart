

import 'package:hive_flutter/hive_flutter.dart';
// part 'admin_model.g.dart';
part 'admin_model.g.dart';

@HiveType(typeId: 7)
class AdminModel extends HiveObject{

  @HiveField(0)
  final String image;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String? id;
  AdminModel({this.id, required this.image, required this.name}); 
}