import 'package:bloc/bloc.dart';
import 'package:fakeslink/app/model/repositories/user_respository.dart';
import 'package:fakeslink/app/viewmodel/profile/view_profile/view_profile_state.dart';

class ViewProfileCubit extends Cubit<ViewProfileState> {
  final UserRepository _userRepository = UserRepositoryImpl();
  ViewProfileCubit()
      : super(const ViewProfileState(
            status: ViewProfileStatus.initial, data: null));
  void getProfile() {
    emit(state.copyWith(status: ViewProfileStatus.loading));
    _userRepository.getProfile().then((value) {
      emit(state.copyWith(status: ViewProfileStatus.success, data: value));
    }).catchError((e) {
      emit(state.copyWith(status: ViewProfileStatus.error));
    });
  }
}
