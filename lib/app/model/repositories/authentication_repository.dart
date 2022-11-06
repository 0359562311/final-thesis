import 'package:fakeslink/app/model/data_sources/authentication_local_source.dart';
import 'package:fakeslink/app/model/data_sources/authentication_remote_source.dart';
import 'package:fakeslink/app/model/entities/session.dart';

mixin IAuthenticationRepository {
  Future<Session> login(String email, String password);
  void saveSession(Session session);
}

class AuthenticationRepositoryImpl implements IAuthenticationRepository {
  final AuthenticationRemoteSource _remoteSource = AuthenticationRemoteSource();
  final AuthenticationLocalSource _localSource = AuthenticationLocalSource();

  @override
  Future<Session> login(String email, String password) {
    return _remoteSource.login(email, password);
  }

  @override
  void saveSession(Session session) {
    _localSource.saveSession(session);
  }
}
