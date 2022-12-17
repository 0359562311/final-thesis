import 'package:hive_flutter/hive_flutter.dart';
part 'bank.g.dart';

@HiveType(typeId: 6)
class BankAccount {
  @HiveField(0)
  final int? id;
  @HiveField(1)
  final Bank? bank;
  @HiveField(2)
  final String? owner;
  @HiveField(3)
  final String? accountNumber;

  BankAccount({
    this.id,
    this.bank,
    this.owner,
    this.accountNumber,
  });

  BankAccount.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        bank = (json['bank'] as Map<String, dynamic>?) != null
            ? Bank.fromJson(json['bank'] as Map<String, dynamic>)
            : null,
        owner = json['owner'] as String?,
        accountNumber = json['accountNumber'] as String?;

  Map<String, dynamic> toJson() =>
      {'bank': bank?.id, 'owner': owner, 'accountNumber': accountNumber};
}

@HiveType(typeId: 7)
class Bank {
  @HiveField(0)
  final int? id;
  @HiveField(1)
  final String? bankId;
  @HiveField(2)
  final String? name;

  Bank({
    this.id,
    this.bankId,
    this.name,
  });

  Bank.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        bankId = json['bankId'] as String?,
        name = json['name'] as String?;

  Map<String, dynamic> toJson() => {'id': id, 'bankId': bankId, 'name': name};
}
