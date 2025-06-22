// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'snack.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SnackAdapter extends TypeAdapter<Snack> {
  @override
  final int typeId = 0;

  @override
  Snack read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Snack(
      id: fields[0] as String,
      name: fields[1] as String,
      image: fields[2] as String,
      description: fields[3] as String,
      country: fields[4] as String,
      flag: fields[5] as String,
      userId: fields[6] as String,
      amount: fields[7] as int,
      isSwapped: fields[8] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Snack obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.image)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.country)
      ..writeByte(5)
      ..write(obj.flag)
      ..writeByte(6)
      ..write(obj.userId)
      ..writeByte(7)
      ..write(obj.amount)
      ..writeByte(8)
      ..write(obj.isSwapped);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SnackAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
