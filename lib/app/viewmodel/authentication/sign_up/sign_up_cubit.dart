import 'package:fakeslink/app/model/repositories/authentication_repository.dart';
import 'package:fakeslink/app/viewmodel/authentication/sign_up/sign_up_state.dart';
import 'package:fakeslink/core/utils/validator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final AuthenticationRepository _repository = AuthenticationRepositoryImpl();

  SignUpCubit() : super(SignUpInitialState());

  String? errorEmail;
  String? errorPassword;
  String? errorConfirmPassword;

  void signUp(String email, String password) {
    emit(SignUpLoadingState());
    _repository.signUp(email, password).then((value) {
      emit(SignUpSuccessState());
    }).catchError((_) {
      emit(SignUpErrorState());
    });
  }

  void validateEmail(String email) {
    errorEmail = Validator.validateEmail(email);
    emit(SignUpInitialState());
  }

  void validatePassword(String password, String confirmPassword) {
    errorPassword = Validator.validatePassword(password);
    if (password != confirmPassword) {
      errorConfirmPassword = "Không khớp với mật khẩu";
    }
    emit(SignUpInitialState());
  }

  void validateConfirmPassword(String password, String confirmPassword) {
    if (password != confirmPassword) {
      errorConfirmPassword = "Không khớp với mật khẩu";
      emit(SignUpInitialState());
      return;
    }
    errorConfirmPassword = Validator.validatePassword(confirmPassword);
    emit(SignUpInitialState());
  }
}
