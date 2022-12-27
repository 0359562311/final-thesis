class DayRequest {
  int? days;

  DayRequest({
    this.days,
  });

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['days'] = days;
    return data;
  }
}
