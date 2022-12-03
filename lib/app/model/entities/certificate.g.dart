// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'certificate.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CertificateAdapter extends TypeAdapter<Certificate> {
  @override
  final int typeId = 5;

  @override
  Certificate read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Certificate(
      from: fields[0] as String?,
      to: fields[1] as String?,
      description: fields[2] as String?,
      title: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Certificate obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.from)
      ..writeByte(1)
      ..write(obj.to)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.title);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CertificateAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
