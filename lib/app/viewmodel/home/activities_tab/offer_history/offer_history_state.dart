import 'package:fakeslink/app/model/entities/offers.dart';

enum OfferHistoryStatus { error, loading, success }

class OfferHistoryState {
  final OfferHistoryStatus status;
  final List<Offer>? offerHistory;

  OfferHistoryState({required this.status, this.offerHistory});

  OfferHistoryState copyWith(
      {OfferHistoryStatus? status, List<Offer>? offerHistory}) {
    return OfferHistoryState(
        status: status ?? this.status,
        offerHistory: offerHistory ?? this.offerHistory);
  }
}
