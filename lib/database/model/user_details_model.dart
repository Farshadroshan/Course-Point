
import 'package:hive_flutter/hive_flutter.dart';
part 'user_details_model.g.dart';
@HiveType(typeId: 6)
class UserDetailsModel extends HiveObject{

  // @HiveField(0)
  // final String image;
  @HiveField(1)
  final String name;

  @HiveField(2)
  String userid;

 UserDetailsModel({ required this.name, required this.userid});
 
}