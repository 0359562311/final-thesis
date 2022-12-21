import 'package:fakeslink/app/model/entities/review_response.dart';
import 'package:fakeslink/app/model/entities/user.dart';

enum ViewProfileStatus { loading, error, success, initial }

class ViewProfileState {
  final ViewProfileStatus status;
  final User? data;
  final List<ReviewResponse>? listReview;

  const ViewProfileState({required this.status, this.data, this.listReview});

  ViewProfileState copyWith(
      {ViewProfileStatus? status,
      User? data,
      List<ReviewResponse>? listReview}) {
    return ViewProfileState(
        status: status ?? this.status,
        data: data ?? this.data,
        listReview: listReview ?? this.listReview);
  }
}
