import 'package:fakeslink/app/model/entities/address.dart';
import 'package:fakeslink/app/model/entities/job.dart';
import 'package:fakeslink/app/model/entities/payment.dart';
import 'package:fakeslink/app/model/entities/user.dart';

class PaymentOffer {
  int? id;
  User? user;
  Job? job;
  String? status;
  int? price;
  String? description;

  PaymentOffer({
    this.id,
    this.user,
    this.job,
    this.status,
    this.price,
    this.description,
  });
  PaymentOffer.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    user = (json['user'] != null) ? User.fromJson(json['user']) : null;
    job = (json['job'] != null) ? Job.fromJson(json['job']) : null;
    status = json['status']?.toString();
    price = json['price']?.toInt();
    description = json['description']?.toString();
  }
}

class JobPayment {
  int? id;
  PaymentOffer? offer;
  int? receiveAmount;

  JobPayment({
    this.id,
    this.offer,
    this.receiveAmount,
  });
  JobPayment.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    offer =
        (json['offer'] != null) ? PaymentOffer.fromJson(json['offer']) : null;
    receiveAmount = json['receiveAmount']?.toInt();
  }
}

class PayOfferResponse {
  int? id;
  String? deposit;
  String? withdraw;
  JobPayment? jobPayment;
  int? amount;
  String? createAt;
  String? updatedAt;
  String? status;
  int? user;
  String? jobPromotion;
  String? profilePromotion;
  String? viewJobSeekers;

  PayOfferResponse({
    this.id,
    this.deposit,
    this.withdraw,
    this.jobPayment,
    this.amount,
    this.createAt,
    this.updatedAt,
    this.status,
    this.user,
    this.jobPromotion,
    this.profilePromotion,
    this.viewJobSeekers,
  });
  PayOfferResponse.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    deposit = json['deposit']?.toString();
    withdraw = json['withdraw']?.toString();
    jobPayment = (json['jobPayment'] != null)
        ? JobPayment.fromJson(json['jobPayment'])
        : null;
    amount = json['amount']?.toInt();
    createAt = json['createAt']?.toString();
    updatedAt = json['updatedAt']?.toString();
    status = json['status']?.toString();
    user = json['user']?.toInt();
    jobPromotion = json['jobPromotion']?.toString();
    profilePromotion = json['profilePromotion']?.toString();
    viewJobSeekers = json['viewJobSeekers']?.toString();
  }
}
