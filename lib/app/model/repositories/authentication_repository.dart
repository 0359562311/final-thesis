import 'package:fakeslink/app/model/data_sources/authentication_local_source.dart';
import 'package:fakeslink/app/model/data_sources/authentication_remote_source.dart';
import 'package:fakeslink/app/model/entities/session.dart';

mixin AuthenticationRepository {
  Future<Session> login(String email, String password);
  Future<void> signUp(String email, String password);
  Future<void> signOut();
  void saveSession(Session session);
}

class AuthenticationRepositoryImpl implements AuthenticationRepository {
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

  @override
  Future<void> signUp(String email, String password) {
    return _remoteSource.signUp(email, password);
  }

  @override
  Future<void> signOut() {
    return _localSource.signOut();
  }
}
