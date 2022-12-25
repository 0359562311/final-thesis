import 'package:fakeslink/app/model/repositories/authentication_repository.dart';
import 'package:fakeslink/app/viewmodel/authentication/login/login_state.dart';
import 'package:fakeslink/core/utils/validator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginViewModel extends Cubit<LoginState> {
  final AuthenticationRepository _authenticationRepository =
      AuthenticationRepositoryImpl();

  LoginViewModel() : super(LoginState(status: LoginStatus.initial));

  void login(String email, String password) {
    if (state.errorEmail == null && state.errorPassword == null) {
      emit(state.copyWith(status: LoginStatus.loading));
      _authenticationRepository.login(email, password).then((value) {
        _authenticationRepository.saveSession(value);
        emit(state.copyWith(status: LoginStatus.success));
      }).catchError((_) {
        emit(state.copyWith(
            status: LoginStatus.error,
            error: "Email hoặc mật khẩu không đúng"));
      });
    }
  }

  void validateEmail(String email) {
    emit(state.copyWith(
        errorEmail: Validator.validateEmail(email),
        errorPassword: state.errorPassword));
  }

  void validatePassword(String password) {
    emit(state.copyWith(
        errorPassword: Validator.validatePassword(password),
        errorEmail: state.errorEmail));
  }
}
