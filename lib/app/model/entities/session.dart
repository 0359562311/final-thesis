import 'package:hive/hive.dart';
part 'session.g.dart';

@HiveType(typeId: 1)
class Session {
  @HiveField(0)
  final String access;
  @HiveField(1)
  final String refresh;
  Session({
    required this.access,
    required this.refresh,
  });

  Map<String, dynamic> toJson() {
    return {
      'access': access,
      'refresh': refresh,
    };
  }

  factory Session.fromJson(Map<String, dynamic> map) {
    return Session(
      access: map['access'] ?? '',
      refresh: map['refresh'] ?? '',
    );
  }
}
