import 'package:fakeslink/app/model/entities/session.dart';
import 'package:hive/hive.dart';

class AuthenticationLocalSource {
  void saveSession(Session session) async {
    final box = await Hive.openBox("configuration");
    box.put("session", session);
  }
}
