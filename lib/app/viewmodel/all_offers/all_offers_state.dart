import 'package:fakeslink/app/model/entities/offers.dart';

enum AllOfferStatus { loading, success, error, acceptSuccess }

class AllOffersState {
  AllOfferStatus status;
  final List<Offer>? offers;

  AllOffersState({required this.status, this.offers});

  AllOffersState copyWith({AllOfferStatus? status, List<Offer>? offers}) {
    return AllOffersState(
        status: status ?? this.status, offers: offers ?? this.offers);
  }
}
