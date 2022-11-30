import 'package:fakeslink/app/model/response/profile_response.dart';

enum ViewProfileStatus { loading, error, success, initial }

class ViewProfileState {
  final ViewProfileStatus status;
  final ProfileResponse? data;

  const ViewProfileState({required this.status, this.data});

  ViewProfileState copyWith(
      {ViewProfileStatus? status, ProfileResponse? data}) {
    return ViewProfileState(
        status: status ?? this.status, data: data ?? this.data);
  }
}
