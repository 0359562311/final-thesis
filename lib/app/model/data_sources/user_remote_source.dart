import 'package:dio/dio.dart';
import 'package:fakeslink/app/model/entities/bank.dart';
import 'package:fakeslink/app/model/entities/review_response.dart';
import 'package:fakeslink/app/model/entities/user.dart';
import 'package:fakeslink/app/model/request/update_bank_account_request.dart';
import 'package:get_it/get_it.dart';

class UserRemoteSource {
  Future<User> getProfile({int? userId}) async {
    if (userId != null) {
      final res = await GetIt.I<Dio>().get("/user/$userId");
      return User.fromJson(res.data);
    } else {
      final res = await GetIt.I<Dio>().get("/user/me");
      return User.fromJson(res.data);
    }
  }

  Future<List<Bank>> getBanks() async {
    final res = await GetIt.I<Dio>().get("/payment/banks");
    return res.data.map<Bank>((e) => Bank.fromJson(e)).toList();
  }

  Future<void> updateBankAccount(UpdateBankAccountRequest request) async {
    final res =
        await GetIt.I<Dio>().put("/user/bank_account/", data: request.toJson());
    return;
  }

  Future<List<ReviewResponse>> getReview(int userId) async {
    final res = (await GetIt.I<Dio>().get("/user/$userId/ratings")).data;
    return (res as List).map((e) => ReviewResponse.fromJson(e)).toList();
  }
}
