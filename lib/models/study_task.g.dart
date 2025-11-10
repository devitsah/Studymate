// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'study_task.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StudyTaskAdapter extends TypeAdapter<StudyTask> {
  @override
  final int typeId = 1;

  @override
  StudyTask read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StudyTask(
      subject: fields[0] as String,
      topic: fields[1] as String,
      dueDate: fields[2] as DateTime,
      isDone: fields[3] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, StudyTask obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.subject)
      ..writeByte(1)
      ..write(obj.topic)
      ..writeByte(2)
      ..write(obj.dueDate)
      ..writeByte(3)
      ..write(obj.isDone);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StudyTaskAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
