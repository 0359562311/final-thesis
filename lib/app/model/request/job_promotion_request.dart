class JobPromotionRequest {
  int? jobId;
  int? days;

  JobPromotionRequest({
    this.jobId,
    this.days,
  });
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['jobId'] = jobId;
    data['days'] = days;
    return data;
  }
}
