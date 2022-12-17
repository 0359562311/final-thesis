import 'dart:convert';

class UpdateBankAccountRequest {
  String owner;
  String accountNumber;
  int bank;
  UpdateBankAccountRequest({
    required this.owner,
    required this.accountNumber,
    required this.bank,
  });

  Map<String, dynamic> toJson() {
    return {
      'owner': owner,
      'accountNumber': accountNumber,
      'bank': bank,
    };
  }
}
