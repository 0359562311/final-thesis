class Session {
  final String access;
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
