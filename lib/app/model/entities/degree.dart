import 'package:hive/hive.dart';
part 'degree.g.dart';

@HiveType(typeId: 3)
class Degree {
  @HiveField(0)
  String? title;
  @HiveField(1)
  String? organization;
  @HiveField(2)
  int? year;

  Degree({
    this.title,
    this.organization,
    this.year,
  });
  Degree.fromJson(Map<String, dynamic> json) {
    title = json['title']?.toString();
    organization = json['organization']?.toString();
    year = json['year']?.toInt();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['title'] = title;
    data['organization'] = organization;
    data['year'] = year;
    return data;
  }
}
