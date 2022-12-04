import 'package:hive/hive.dart';
part 'experience.g.dart';

@HiveType(typeId: 4)
class Experience {
  @HiveField(0)
  String? From;
  @HiveField(1)
  String? to;
  @HiveField(2)
  String? description;

  Experience({
    this.From,
    this.to,
    this.description,
  });
  Experience.fromJson(Map<String, dynamic> json) {
    From = json['_from']?.toString();
    to = json['to']?.toString();
    description = json['description']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['_from'] = From;
    data['to'] = to;
    data['description'] = description;
    return data;
  }
}
