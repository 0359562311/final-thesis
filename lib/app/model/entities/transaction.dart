import 'package:fakeslink/app/model/entities/bank.dart';
import 'package:fakeslink/core/utils/extensions/num.dart';
import 'package:fakeslink/main.dart';

import 'offers.dart';

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
  final ProfilePromotionTransaction? profilePromotion;
  final dynamic viewJobSeekers;
  final JobPaymentTransaction? jobPayment;

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
        profilePromotion = json['profilePromotion'] != null
            ? ProfilePromotionTransaction.fromJson(json['profilePromotion'])
            : null,
        viewJobSeekers = json['viewJobSeekers'],
        jobPayment = (json['jobPayment'] as Map<String, dynamic>?) != null
            ? JobPaymentTransaction.fromJson(
                json['jobPayment'] as Map<String, dynamic>)
            : null;

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
        'profilePromotion': profilePromotion,
        'viewJobSeekers': viewJobSeekers,
        'jobPayment': jobPayment
      };

  String get type {
    if (deposit != null)
      return "Nạp tiền";
    else if (withdraw != null)
      return "Rút tiền";
    else if (jobPromotion != null)
      return "Đẩy tìm kiếm công việc";
    else if (profilePromotion != null)
      return "Đẩy tìm kiếm hồ sơ";
    else if (jobPayment != null) {
      return "Thanh toán công việc";
    }
    return "";
  }

  String get zAmount {
    if (deposit != null ||
        (jobPayment != null &&
            jobPayment!.offer!.user!.id == configBox.get('user')?.id))
      return "+" + (amount ?? 0).price + " VND";
    return "-" + (amount ?? 0).price + " VND";
  }
}

class ProfilePromotionTransaction {
  final int? id;
  final String? dueDate;

  ProfilePromotionTransaction({this.id, this.dueDate});

  ProfilePromotionTransaction.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        dueDate = json['dueDate'] as String?;
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

class JobPaymentTransaction {
  final int? id;
  final Offer? offer;
  final int? receiveAmount;

  JobPaymentTransaction({
    this.id,
    this.offer,
    this.receiveAmount,
  });

  JobPaymentTransaction.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        offer = (json['offer'] as Map<String, dynamic>?) != null
            ? Offer.fromJson(json['offer'] as Map<String, dynamic>)
            : null,
        receiveAmount = json['receiveAmount'] as int?;
}
