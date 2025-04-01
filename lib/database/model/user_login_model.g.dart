// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_login_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserLoginModelAdapter extends TypeAdapter<UserLoginModel> {
  @override
  final int typeId = 1;

  @override
  UserLoginModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserLoginModel(
      password: fields[0] as String,
      email: fields[1] as dynamic,
      id: fields[2] as String?,
      name: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, UserLoginModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.password)
      ..writeByte(1)
      ..write(obj.email)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.name);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserLoginModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
