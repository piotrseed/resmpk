// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'like_storage.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LikeStorageAdapter extends TypeAdapter<LikeStorage> {
  @override
  final int typeId = 0;

  @override
  LikeStorage read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LikeStorage(
      likeId: fields[0] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, LikeStorage obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.likeId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LikeStorageAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
