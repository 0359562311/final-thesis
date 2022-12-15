class BankAccount {
  final int? id;
  final Bank? bank;
  final String? owner;
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

  Map<String, dynamic> toJson() => {
        'id': id,
        'bank': bank?.toJson(),
        'owner': owner,
        'accountNumber': accountNumber
      };
}

class Bank {
  final int? id;
  final String? bankId;
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
