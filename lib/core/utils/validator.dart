final _emailRegex = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

abstract class Validator {
  static String? validateEmail(String email) {
    if (_emailRegex.hasMatch(email.trim())) {
      return null;
    } else {
      return "Email không đúng định dạng";
    }
  }

  static String? validatePassword(String password) {
    password = password.trim();
    if (password.length < 6) {
      return "Mật khẩu phải nhiều hơn 6 ký tự";
    }
    return null;
  }
}
