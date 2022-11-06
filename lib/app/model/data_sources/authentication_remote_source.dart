import 'package:dio/dio.dart';
import 'package:fakeslink/app/model/entities/session.dart';
import 'package:get_it/get_it.dart';

class AuthenticationRemoteSource {
  Future<Session> login(String email, String password) async {
    final res = await GetIt.I<Dio>().post("/auth/jwt/create/",
        data: {"email": email, "password": password});
    return Session.fromJson(res.data);
  }
}
