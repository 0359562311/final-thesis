import 'package:shared_preferences/shared_preferences.dart';

class SharePreferencesUtils {
  late final SharedPreferences _instance;
  Future init() async {
    _instance = await SharedPreferences.getInstance();
  }

  Future setInt(String key, int value) {
    return _instance.setInt(key, value).then((value) => _instance.reload());
  }

  int? getInt(String key) {
    return _instance.getInt(key);
  }

  Future setString(String key, String value) {
    return _instance.setString(key, value).then((value) => _instance.reload());
  }

  String? getString(String key) {
    return _instance.getString(key);
  }

  Future reset() {
    return _instance.clear();
  }

  void clearSession() {
    _instance.remove("access");
    _instance.remove("refresh");
  }
}
