import 'package:bloc/bloc.dart';
import 'package:fakeslink/app/model/repositories/user_respository.dart';
import 'package:fakeslink/app/model/request/day_request.dart';
import 'package:fakeslink/app/viewmodel/profile/view_profile/view_profile_state.dart';

class ViewProfileViewModel extends Cubit<ViewProfileState> {
  final UserRepository _userRepository = UserRepositoryImpl();
  int? price;
  ViewProfileViewModel()
      : super(const ViewProfileState(
            status: ViewProfileStatus.initial, data: null));
  void getProfile(int? id) {
    emit(state.copyWith(status: ViewProfileStatus.loading));
    _userRepository.getProfile(id).then((value) {
      emit(state.copyWith(status: ViewProfileStatus.success, data: value));
    }).catchError((e) {
      emit(state.copyWith(status: ViewProfileStatus.error));
    });
  }

  void getReview(int? userId) {
    emit(state.copyWith(status: ViewProfileStatus.loading));
    _userRepository.getReview(userId ?? 0).then((value) {
      emit(
          state.copyWith(status: ViewProfileStatus.success, listReview: value));
    }).catchError((onError) {
      emit(state.copyWith(status: ViewProfileStatus.error));
    });
  }

  void requestDay(int day) {
    emit(state.copyWith(status: ViewProfileStatus.loading));
    _userRepository.requestDay(DayRequest(days: day)).then((value) {
      emit(state.copyWith(
          status: ViewProfileStatus.inputDaySuccess, data: value));
    }).catchError((onError) {
      emit(state.copyWith(status: ViewProfileStatus.error));
    });
  }

  int? priceAdvertisement({required int balance, required int day}) {
    price = balance * day;
    return price;
  }
}
