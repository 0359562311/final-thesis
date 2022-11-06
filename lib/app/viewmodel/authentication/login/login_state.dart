enum LoginStatus { loading, error, success, initial }

class LoginState {
  final LoginStatus status;
  final String? errorEmail;
  final String? errorPassword;
  final String? error;
  LoginState({
    required this.status,
    this.errorEmail,
    this.errorPassword,
    this.error,
  });

  LoginState copyWith({
    LoginStatus? status,
    String? errorEmail,
    String? errorPassword,
    String? error,
  }) {
    return LoginState(
      status: status ?? this.status,
      errorEmail: errorEmail,
      errorPassword: errorPassword,
      error: error,
    );
  }
}
