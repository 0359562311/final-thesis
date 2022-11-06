abstract class SignUpState {}

class SignUpInitialState extends SignUpState {}

class SignUpLoadingState extends SignUpState {}

class SignUpErrorState extends SignUpState {
  final String? message;

  SignUpErrorState({this.message});
}

class SignUpSuccessState extends SignUpState {}
