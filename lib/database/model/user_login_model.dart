import 'package:hive_flutter/hive_flutter.dart';
part 'user_login_model.g.dart';


@HiveType(typeId: 1)
class UserLoginModel extends HiveObject{
  @HiveField(0)
  final String password;
  @HiveField(1)
  var email;
  @HiveField(2)
  String? id;
  @HiveField(3)
  final String name;

  UserLoginModel({required this.password, required this.email, this.id,required this.name});
}
