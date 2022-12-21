class ReviewRequest {
  int? transactionId;
  int? rating;
  String? detail;

  ReviewRequest({
    this.transactionId,
    this.rating,
    this.detail,
  });

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['transactionId'] = transactionId;
    data['rating'] = rating;
    data['detail'] = detail;
    return data;
  }
}
