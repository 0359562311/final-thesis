import 'package:fakeslink/app/model/repositories/job_repository.dart';
import 'package:fakeslink/app/model/request/accept_offers.dart';
import 'package:fakeslink/app/viewmodel/all_offers/all_offers_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllOffersCubit extends Cubit<AllOffersState> {
  final JobRepository offer = JobRepositoryImpl();
  AllOffersCubit() : super(AllOffersState(status: AllOfferStatus.loading));

  void getAllOffer({int? offerId}) {
    emit(state.copyWith(status: AllOfferStatus.loading));
    offer.getOffers(offerId ?? 0).then((value) {
      emit(state.copyWith(status: AllOfferStatus.success, offers: value));
    }).catchError((onError) {
      emit(state.copyWith(status: AllOfferStatus.error));
    });
  }

  void accept({int? id}) {
    emit(state.copyWith(status: AllOfferStatus.loading));
    offer.acceptOffer(AcceptOffers(status: "Pending"), jobId: id).then((value) {
      emit(state.copyWith(status: AllOfferStatus.acceptSuccess));
    }).catchError((onError) {
      emit(state.copyWith(status: AllOfferStatus.error));
    });
  }
}
