// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subcourse_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SubcourseModelAdapter extends TypeAdapter<SubcourseModel> {
  @override
  final int typeId = 3;

  @override
  SubcourseModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SubcourseModel(
      subcourseimage: fields[0] as String,
      subcoursetitle: fields[1] as String,
      id: fields[2] as String?,
      courseId: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, SubcourseModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.subcourseimage)
      ..writeByte(1)
      ..write(obj.subcoursetitle)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.courseId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SubcourseModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
