import 'package:fakeslink/app/model/entities/offers.dart';
import 'package:fakeslink/app/model/entities/transaction.dart';

enum AllOfferStatus {
  loading,
  success,
  error,
  acceptSuccess,
  paySuccess,
  reviewSuccess
}

class AllOffersState {
  AllOfferStatus status;
  final List<Offer>? offers;
  final Transaction? transaction;
  final int? jobId;

  AllOffersState(
      {required this.status, this.offers, this.transaction, this.jobId});

  AllOffersState copyWith(
      {AllOfferStatus? status,
      List<Offer>? offers,
      Transaction? transaction,
      int? jobId}) {
    return AllOffersState(
        status: status ?? this.status,
        offers: offers ?? this.offers,
        transaction: transaction ?? this.transaction,
        jobId: jobId);
  }
}
