import 'package:fakeslink/app/model/data_sources/user_local_source.dart';
import 'package:fakeslink/app/model/data_sources/user_remote_source.dart';
import 'package:fakeslink/app/model/entities/bank.dart';
import 'package:fakeslink/app/model/entities/user.dart';
import 'package:fakeslink/app/model/request/update_bank_account_request.dart';

mixin UserRepository {
  Future<User> getProfile();
  Future<void> updateBankAccount(UpdateBankAccountRequest request);
  Future<List<Bank>> getBanks();
}

class UserRepositoryImpl implements UserRepository {
  final UserRemoteSource _remoteSource = UserRemoteSource();
  final UserLocalSource _localSource = UserLocalSource();
  @override
  Future<User> getProfile() {
    return _remoteSource.getProfile().then((value) async {
      await _localSource.save(value);
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
}
