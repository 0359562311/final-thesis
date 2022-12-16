import 'package:fakeslink/app/model/repositories/authentication_repository.dart';
import 'package:fakeslink/app/viewmodel/authentication/verify_password/verify_password_state.dart';
import 'package:fakeslink/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerifyPasswordViewModel extends Cubit<VerifyPasswordState> {
  final AuthenticationRepository _authenticationRepository =
      AuthenticationRepositoryImpl();

  VerifyPasswordViewModel() : super(VerifyPasswordInitialState());

  void auth(String password) {
    _authenticationRepository
        .login(configBox.get('user').email, password)
        .then((value) {
      emit(VerifyPasswordSuccessState());
    }).catchError((_) {
      emit(VerifyPasswordErrorState());
    });
  }
}
