import 'package:fakeslink/app/model/entities/user.dart';

class ReviewResponse {
  int? id;
  User? user;
  int? rating;
  String? detail;
  int? offer;

  ReviewResponse({
    this.id,
    this.user,
    this.rating,
    this.detail,
    this.offer,
  });
  ReviewResponse.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    user = (json['user'] != null) ? User.fromJson(json['user']) : null;
    rating = json['rating']?.toInt();
    detail = json['detail']?.toString();
    offer = json['offer']?.toInt();
  }
}
