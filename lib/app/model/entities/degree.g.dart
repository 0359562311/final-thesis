// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'degree.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DegreeAdapter extends TypeAdapter<Degree> {
  @override
  final int typeId = 3;

  @override
  Degree read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Degree(
      title: fields[0] as String?,
      organization: fields[1] as String?,
      year: fields[2] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, Degree obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.organization)
      ..writeByte(2)
      ..write(obj.year);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DegreeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
