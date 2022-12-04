// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserAdapter extends TypeAdapter<User> {
  @override
  final int typeId = 2;

  @override
  User read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return User(
      id: fields[0] as int?,
      name: fields[1] as String?,
      dob: fields[2] as String?,
      avatar: fields[3] as String?,
      cover: fields[4] as String?,
      gender: fields[5] as String?,
      phoneNumber: fields[6] as String?,
      createAt: fields[7] as String?,
      updateAt: fields[8] as String?,
      email: fields[9] as String?,
      loyaltyPoint: fields[10] as int?,
      bankAccount: fields[11] as String?,
      degrees: (fields[12] as List?)?.cast<Degree?>(),
      experiences: (fields[13] as List?)?.cast<Experience?>(),
      certificates: (fields[14] as List?)?.cast<Certificate?>(),
      bio: fields[15] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer
      ..writeByte(16)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.dob)
      ..writeByte(3)
      ..write(obj.avatar)
      ..writeByte(4)
      ..write(obj.cover)
      ..writeByte(5)
      ..write(obj.gender)
      ..writeByte(6)
      ..write(obj.phoneNumber)
      ..writeByte(7)
      ..write(obj.createAt)
      ..writeByte(8)
      ..write(obj.updateAt)
      ..writeByte(9)
      ..write(obj.email)
      ..writeByte(10)
      ..write(obj.loyaltyPoint)
      ..writeByte(11)
      ..write(obj.bankAccount)
      ..writeByte(12)
      ..write(obj.degrees)
      ..writeByte(13)
      ..write(obj.experiences)
      ..writeByte(14)
      ..write(obj.certificates)
      ..writeByte(15)
      ..write(obj.bio);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
