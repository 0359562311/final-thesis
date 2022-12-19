import 'package:bloc/bloc.dart';
import 'package:fakeslink/app/model/repositories/user_respository.dart';
import 'package:fakeslink/app/viewmodel/profile/view_profile/view_profile_state.dart';

class ViewProfileViewModel extends Cubit<ViewProfileState> {
  final UserRepository _userRepository = UserRepositoryImpl();
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
}
