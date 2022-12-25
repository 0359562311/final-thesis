import 'package:fakeslink/app/model/repositories/job_repository.dart';
import 'package:fakeslink/app/viewmodel/home/activities_tab/offer_history/offer_history_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OfferHistoryViewModel extends Cubit<OfferHistoryState> {
  final JobRepository _repository = JobRepositoryImpl();
  OfferHistoryViewModel()
      : super(OfferHistoryState(status: OfferHistoryStatus.loading));

  void getOfferHistory() {
    emit(state.copyWith(status: OfferHistoryStatus.loading));
    _repository.getOfferHistory().then((value) {
      emit(state.copyWith(
          status: OfferHistoryStatus.success, offerHistory: value));
    }).catchError((onError) {
      emit(state.copyWith(status: OfferHistoryStatus.error));
    });
  }
}
