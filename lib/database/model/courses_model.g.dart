// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'courses_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CoursesModelAdapter extends TypeAdapter<CoursesModel> {
  @override
  final int typeId = 2;

  @override
  CoursesModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CoursesModel(
      image: fields[0] as String,
      coursetitle: fields[1] as String,
      indroductionvideo: fields[2] as String,
      Description: fields[3] as String,
      id: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, CoursesModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.image)
      ..writeByte(1)
      ..write(obj.coursetitle)
      ..writeByte(2)
      ..write(obj.indroductionvideo)
      ..writeByte(3)
      ..write(obj.Description)
      ..writeByte(4)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CoursesModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
