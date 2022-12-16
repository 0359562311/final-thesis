import 'package:fakeslink/app/model/entities/user.dart';

class OffersResponse {
  int? id;
  User? user;
  String? status;
  int? price;
  String? description;
  int? job;

  OffersResponse({
    this.id,
    this.user,
    this.status,
    this.price,
    this.description,
    this.job,
  });
  OffersResponse.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    user = (json['user'] != null) ? User.fromJson(json['user']) : null;
    status = json['status']?.toString();
    price = json['price']?.toInt();
    description = json['description']?.toString();
    job = json['job']?.toInt();
  }
}