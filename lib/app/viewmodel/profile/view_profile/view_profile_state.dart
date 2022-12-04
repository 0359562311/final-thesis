import 'package:fakeslink/app/model/entities/user.dart';

enum ViewProfileStatus { loading, error, success, initial }

class ViewProfileState {
  final ViewProfileStatus status;
  final User? data;

  const ViewProfileState({required this.status, this.data});

  ViewProfileState copyWith(
      {ViewProfileStatus? status, User? data}) {
    return ViewProfileState(
        status: status ?? this.status, data: data ?? this.data);
  }
}
