import 'package:fakeslink/app/model/data_sources/user_source.dart';
import 'package:fakeslink/app/model/response/profile_response.dart';

mixin UserRepository {
  Future<ProfileResponse> getProfile();
}

class UserRepositoryImpl implements UserRepository {
  final UseSource _useSource = UseSource();
  @override
  Future<ProfileResponse> getProfile() {
    return _useSource.getProfile();
  }
}
