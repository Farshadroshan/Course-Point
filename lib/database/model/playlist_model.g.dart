// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playlist_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PlaylistModelAdapter extends TypeAdapter<PlaylistModel> {
  @override
  final int typeId = 4;

  @override
  PlaylistModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PlaylistModel(
      playlistVideo: fields[0] as String,
      plalistTitle: fields[1] as String,
      id: fields[2] as String?,
      subcourseId: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, PlaylistModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.playlistVideo)
      ..writeByte(1)
      ..write(obj.plalistTitle)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.subcourseId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlaylistModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
