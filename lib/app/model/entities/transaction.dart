import 'package:fakeslink/app/model/entities/bank.dart';

enum TransactionStatus { Pending, Failed, Success }

class Transaction {
  final int? id;
  final DepositTransaction? deposit;
  final WithdrawTransaction? withdraw;
  final int? amount;
  final String? createAt;
  final String? updatedAt;
  final String? status;
  final int? user;
  final dynamic jobPromotion;
  final dynamic profileView;
  final dynamic profilePromotion;
  final dynamic viewJobSeekers;
  final dynamic jobPayment;

  Transaction({
    this.id,
    this.deposit,
    this.withdraw,
    this.amount,
    this.createAt,
    this.updatedAt,
    this.status,
    this.user,
    this.jobPromotion,
    this.profileView,
    this.profilePromotion,
    this.viewJobSeekers,
    this.jobPayment,
  });

  Transaction.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        deposit = (json['deposit'] as Map<String, dynamic>?) != null
            ? DepositTransaction.fromJson(
                json['deposit'] as Map<String, dynamic>)
            : null,
        withdraw = (json['withdraw'] as Map<String, dynamic>?) != null
            ? WithdrawTransaction.fromJson(
                json['withdraw'] as Map<String, dynamic>)
            : null,
        amount = json['amount'] as int?,
        createAt = json['createAt'] as String?,
        updatedAt = json['updatedAt'] as String?,
        status = json['status'] as String?,
        user = json['user'] as int?,
        jobPromotion = json['jobPromotion'],
        profileView = json['profileView'],
        profilePromotion = json['profilePromotion'],
        viewJobSeekers = json['viewJobSeekers'],
        jobPayment = json['jobPayment'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'deposit': deposit?.toJson(),
        'withdraw': withdraw,
        'amount': amount,
        'createAt': createAt,
        'updatedAt': updatedAt,
        'status': status,
        'user': user,
        'jobPromotion': jobPromotion,
        'profileView': profileView,
        'profilePromotion': profilePromotion,
        'viewJobSeekers': viewJobSeekers,
        'jobPayment': jobPayment
      };
}

class DepositTransaction {
  final int? id;
  final String? detail;
  final String? dueDate;
  final dynamic systemBankAccount;

  DepositTransaction({
    this.id,
    this.detail,
    this.dueDate,
    this.systemBankAccount,
  });

  DepositTransaction.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        detail = json['detail'] as String?,
        dueDate = json['dueDate'] as String?,
        systemBankAccount = json['systemBankAccount'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'detail': detail,
        'dueDate': dueDate,
        'systemBankAccount': systemBankAccount
      };
}

class WithdrawTransaction {
  final int? id;
  final String? dueDate;
  final String? detail;
  final BankAccount? userBankAccount;

  WithdrawTransaction({
    this.id,
    this.dueDate,
    this.detail,
    this.userBankAccount,
  });

  WithdrawTransaction.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        dueDate = json['dueDate'] as String?,
        detail = json['detail'] as String?,
        userBankAccount = json['userBankAccount'] == null
            ? null
            : BankAccount.fromJson(json['userBankAccount']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'dueDate': dueDate,
        'detail': detail,
        'userBankAccount': userBankAccount
      };
}
