import 'package:fakeslink/app/model/data_sources/user_local_source.dart';
import 'package:fakeslink/app/model/data_sources/user_remote_source.dart';
import 'package:fakeslink/app/model/entities/user.dart';

mixin UserRepository {
  Future<User> getProfile();
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
}
