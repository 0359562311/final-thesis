class AcceptOffers {
  String? status;

  AcceptOffers({
    this.status,
  });

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status;
    return data;
  }
}
