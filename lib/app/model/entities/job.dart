import 'package:fakeslink/app/model/entities/address.dart';
import 'package:fakeslink/app/model/entities/category.dart';
import 'package:fakeslink/app/model/entities/payment.dart';
import 'package:fakeslink/app/model/entities/user.dart';

enum JobStatus { Pending, Opening, Closed }

class Job {
  final int? id;
  final Payment? payment;
  final Address? address;
  final User? poster;
  final List<Category>? categories;
  final List<String>? images;
  final List<dynamic>? videos;
  final String? title;
  final String? description;
  final String? status;
  final DateTime? dueDate;

  Job(
      {this.id,
      this.payment,
      this.address,
      this.poster,
      this.categories,
      this.images,
      this.videos,
      this.title,
      this.description,
      this.status,
      this.dueDate});

  Job.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        payment = (json['payment'] as Map<String, dynamic>?) != null
            ? Payment.fromJson(json['payment'] as Map<String, dynamic>)
            : null,
        address = (json['address'] as Map<String, dynamic>?) != null
            ? Address.fromJson(json['address'] as Map<String, dynamic>)
            : null,
        poster = (json['poster'] as Map<String, dynamic>?) != null
            ? User.fromJson(json['poster'] as Map<String, dynamic>)
            : null,
        categories = (json['categories'] as List?)
            ?.map((dynamic e) => Category.fromJson(e as Map<String, dynamic>))
            .toList(),
        images =
            (json['images'] as List?)?.map((dynamic e) => e as String).toList(),
        videos = json['videos'] as List?,
        title = json['title'] as String?,
        description = json['description'] as String?,
        status = json['status'] as String?,
        dueDate = DateTime.tryParse(json['dueDate'] ?? "");

  Map<String, dynamic> toJson() => {
        'id': id,
        'payment': payment?.toJson(),
        'address': address?.toJson(),
        'poster': poster?.toJson(),
        'categories': categories?.map((e) => e.id).toList(),
        'images': images,
        'videos': videos,
        'title': title,
        'description': description,
        'status': status
      };

  String get statusText {
    if (status == JobStatus.Opening.name) {
      return "Đang mở";
    } else if (status == JobStatus.Pending.name) {
      return "Chờ hoàn thành";
    }
    return "Đã đóng";
  }
}
