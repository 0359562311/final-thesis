// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bank.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BankAccountAdapter extends TypeAdapter<BankAccount> {
  @override
  final int typeId = 6;

  @override
  BankAccount read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BankAccount(
      id: fields[0] as int?,
      bank: fields[1] as Bank?,
      owner: fields[2] as String?,
      accountNumber: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, BankAccount obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.bank)
      ..writeByte(2)
      ..write(obj.owner)
      ..writeByte(3)
      ..write(obj.accountNumber);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BankAccountAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class BankAdapter extends TypeAdapter<Bank> {
  @override
  final int typeId = 7;

  @override
  Bank read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Bank(
      id: fields[0] as int?,
      bankId: fields[1] as String?,
      name: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Bank obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.bankId)
      ..writeByte(2)
      ..write(obj.name);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BankAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
