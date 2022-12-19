import 'package:fakeslink/app/model/entities/job.dart';
import 'package:fakeslink/app/model/entities/user.dart';

class Offer {
  int? id;
  User? user;
  String? status;
  int? price;
  String? description;
  Job? job;

  Offer({
    this.id,
    this.user,
    this.status,
    this.price,
    this.description,
    this.job,
  });
  Offer.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    user = !(json['user'] == null || json['user'] is int)
        ? User.fromJson(json['user'])
        : null;
    status = json['status']?.toString();
    price = json['price']?.toInt();
    description = json['description']?.toString();
    job = (json['job'] != null) ? Job.fromJson(json['job']) : null;
  }
}
