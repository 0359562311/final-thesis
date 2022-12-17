class AcceptOfferRequest {
  int? offerId;

  AcceptOfferRequest({
    this.offerId,
  });

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['offerId'] = offerId;
    return data;
  }
}
