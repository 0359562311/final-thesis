import 'package:hive/hive.dart';
part 'certificate.g.dart';

@HiveType(typeId: 5)
class Certificate {
  @HiveField(0)
  String? from;
  @HiveField(1)
  String? to;
  @HiveField(2)
  String? description;
  @HiveField(3)
  String? title;

  Certificate({
    this.from,
    this.to,
    this.description,
    this.title,
  });
  Certificate.fromJson(Map<String, dynamic> json) {
    from = json['_from']?.toString();
    to = json['to']?.toString();
    description = json['description']?.toString();
    title = json['title']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['_from'] = from;
    data['to'] = to;
    data['description'] = description;
    data['title'] = title;
    return data;
  }
}
