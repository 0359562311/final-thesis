import 'package:dio/dio.dart';
import 'package:fakeslink/app/model/response/profile_response.dart';
import 'package:get_it/get_it.dart';

class UseSource {
  Future<ProfileResponse> getProfile() async {
    final res = await GetIt.I<Dio>().get("/user/me");
    return ProfileResponse.fromJson(res.data);
  }
}
