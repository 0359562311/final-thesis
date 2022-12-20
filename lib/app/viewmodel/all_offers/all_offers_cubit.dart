import 'package:fakeslink/app/model/repositories/offer_repository.dart';
import 'package:fakeslink/app/model/request/accept_offers.dart';
import 'package:fakeslink/app/model/request/pay_offer_request.dart';
import 'package:fakeslink/app/viewmodel/all_offers/all_offers_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllOffersCubit extends Cubit<AllOffersState> {
  final OfferRepository _offerRepository = OfferRepositoryImpl();

  AllOffersCubit() : super(AllOffersState(status: AllOfferStatus.loading));

  void getAllOffer({int? jobId}) {
    emit(state.copyWith(status: AllOfferStatus.loading));
    _offerRepository.getOffers(jobId ?? 0).then((value) {
      emit(state.copyWith(status: AllOfferStatus.success, offers: value));
    }).catchError((onError) {
      emit(state.copyWith(status: AllOfferStatus.error));
    });
  }

  void accept({required int offerId, required int jobId}) {
    emit(state.copyWith(status: AllOfferStatus.loading));
    _offerRepository
        .acceptOffer(AcceptOfferRequest(offerId: offerId), jobId: jobId)
        .then((value) {
      emit(state.copyWith(status: AllOfferStatus.acceptSuccess));
    }).catchError((onError) {
      emit(state.copyWith(status: AllOfferStatus.error));
    });
  }

  void pay({int? jobId, int? offerId, int? hours}) {
    emit(state.copyWith(status: AllOfferStatus.loading));
    _offerRepository
        .pay(PayOfferRequest(offerId: offerId, hours: hours), jobId: jobId)
        .then((value) {
      emit(state.copyWith(status: AllOfferStatus.paySuccess));
    }).catchError((onError) {
      emit(state.copyWith(status: AllOfferStatus.error));
    });
  }
}
