import 'package:dio/dio.dart';
import 'package:fakeslink/app/model/entities/user.dart';
import 'package:get_it/get_it.dart';

class UserRemoteSource {
  Future<User> getProfile() async {
    final res = await GetIt.I<Dio>().get("/user/me");
    return User.fromJson(res.data);
  }
}
