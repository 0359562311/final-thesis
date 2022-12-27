import 'package:fakeslink/app/model/data_sources/user_local_source.dart';
import 'package:fakeslink/app/model/data_sources/user_remote_source.dart';
import 'package:fakeslink/app/model/entities/bank.dart';
import 'package:fakeslink/app/model/entities/review_response.dart';
import 'package:fakeslink/app/model/entities/user.dart';
import 'package:fakeslink/app/model/request/day_request.dart';
import 'package:fakeslink/app/model/request/update_bank_account_request.dart';

mixin UserRepository {
  Future<User> getProfile(int? userId);
  Future<void> updateBankAccount(UpdateBankAccountRequest request);
  Future<List<Bank>> getBanks();
  Future<List<ReviewResponse>> getReview(int userId);
  Future<User> requestDay(DayRequest request);
}

class UserRepositoryImpl implements UserRepository {
  final UserRemoteSource _remoteSource = UserRemoteSource();
  final UserLocalSource _localSource = UserLocalSource();
  @override
  Future<User> getProfile(int? userId) {
    return _remoteSource.getProfile(userId: userId).then((value) async {
      if (userId == null) await _localSource.save(value);
      return value;
    });
  }

  @override
  Future<List<Bank>> getBanks() {
    return _remoteSource.getBanks();
  }

  @override
  Future<void> updateBankAccount(UpdateBankAccountRequest request) {
    return _remoteSource.updateBankAccount(request);
  }

  @override
  Future<List<ReviewResponse>> getReview(int userId) {
    return _remoteSource.getReview(userId);
  }

  @override
  Future<User> requestDay(DayRequest request) {
    return _remoteSource.requestDay(request);
  }
}
