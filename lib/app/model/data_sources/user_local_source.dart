import 'package:fakeslink/app/model/entities/user.dart';
import 'package:fakeslink/main.dart';

class UserLocalSource {
  Future<User> getProfile() async {
    return configBox.get("user");
  }

  Future<void> save(User user) {
    return configBox.put("user", user);
  }
}
