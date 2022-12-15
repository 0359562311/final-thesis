import 'package:hive/hive.dart';

import 'certificate.dart';
import 'degree.dart';
import 'experience.dart';
part 'user.g.dart';

@HiveType(typeId: 2)
class User {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? name;
  @HiveField(2)
  String? dob;
  @HiveField(3)
  String? avatar;
  @HiveField(4)
  String? cover;
  @HiveField(5)
  String? gender;
  @HiveField(6)
  String? phoneNumber;
  @HiveField(7)
  String? createAt;
  @HiveField(8)
  String? updateAt;
  @HiveField(9)
  String? email;
  @HiveField(10)
  int? loyaltyPoint;
  @HiveField(11)
  String? bankAccount;
  @HiveField(12)
  List<Degree?>? degrees;
  @HiveField(13)
  List<Experience?>? experiences;
  @HiveField(14)
  List<Certificate?>? certificates;
  @HiveField(15)
  String? bio;
  @HiveField(16)
  int? balance;

  User(
      {this.id,
      this.name,
      this.dob,
      this.avatar,
      this.cover,
      this.gender,
      this.phoneNumber,
      this.createAt,
      this.updateAt,
      this.email,
      this.loyaltyPoint,
      this.bankAccount,
      this.degrees,
      this.experiences,
      this.certificates,
      this.balance,
      this.bio});
  User.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    name = json['name']?.toString();
    dob = json['dob']?.toString();
    avatar = json['avatar']?.toString();
    cover = json['cover']?.toString();
    gender = json['gender']?.toString();
    phoneNumber = json['phoneNumber']?.toString();
    createAt = json['createAt']?.toString();
    updateAt = json['updateAt']?.toString();
    email = json['email']?.toString();
    loyaltyPoint = json['loyaltyPoint']?.toInt();
    bankAccount = json['bankAccount']?.toString();
    balance = json['balance'];
    if (json['degrees'] != null) {
      final v = json['degrees'];
      final arr0 = <Degree>[];
      v.forEach((v) {
        arr0.add(Degree.fromJson(v));
      });
      degrees = arr0;
    }
    if (json['experiences'] != null) {
      final v = json['experiences'];
      final arr0 = <Experience>[];
      v.forEach((v) {
        arr0.add(Experience.fromJson(v));
      });
      experiences = arr0;
    }
    if (json['certificates'] != null) {
      final v = json['certificates'];
      final arr0 = <Certificate>[];
      v.forEach((v) {
        arr0.add(Certificate.fromJson(v));
      });
      certificates = arr0;
    }
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['dob'] = dob;
    data['avatar'] = avatar;
    data['cover'] = cover;
    data['gender'] = gender;
    data['phoneNumber'] = phoneNumber;
    data['createAt'] = createAt;
    data['updateAt'] = updateAt;
    data['email'] = email;
    data['loyaltyPoint'] = loyaltyPoint;
    data['bankAccount'] = bankAccount;
    data['bio'] = bio;
    if (degrees != null) {
      final v = degrees;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data['degrees'] = arr0;
    }
    if (experiences != null) {
      final v = experiences;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data['experiences'] = arr0;
    }
    if (certificates != null) {
      final v = certificates;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data['certificates'] = arr0;
    }
    return data;
  }
}
