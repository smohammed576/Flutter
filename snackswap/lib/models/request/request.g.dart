// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RequestAdapter extends TypeAdapter<Request> {
  @override
  final int typeId = 3;

  @override
  Request read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Request(
      id: fields[0] as String,
      user: fields[1] as String,
      sendUser: fields[2] as String,
      snack: fields[3] as String,
      requestSnack: fields[4] as String,
      status: fields[5] as Status,
    );
  }

  @override
  void write(BinaryWriter writer, Request obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.user)
      ..writeByte(2)
      ..write(obj.sendUser)
      ..writeByte(3)
      ..write(obj.snack)
      ..writeByte(4)
      ..write(obj.requestSnack)
      ..writeByte(5)
      ..write(obj.status);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RequestAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class StatusAdapter extends TypeAdapter<Status> {
  @override
  final int typeId = 2;

  @override
  Status read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return Status.pending;
      case 1:
        return Status.accepted;
      case 2:
        return Status.declined;
      case 3:
        return Status.cancelled;
      default:
        return Status.pending;
    }
  }

  @override
  void write(BinaryWriter writer, Status obj) {
    switch (obj) {
      case Status.pending:
        writer.writeByte(0);
        break;
      case Status.accepted:
        writer.writeByte(1);
        break;
      case Status.declined:
        writer.writeByte(2);
        break;
      case Status.cancelled:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StatusAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
