// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'smoothie.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SmoothieAdapter extends TypeAdapter<Smoothie> {
  @override
  final int typeId = 0;

  @override
  Smoothie read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Smoothie(
      id: fields[0] as String,
      name: fields[1] as String,
      options: (fields[2] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, Smoothie obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.options);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SmoothieAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
