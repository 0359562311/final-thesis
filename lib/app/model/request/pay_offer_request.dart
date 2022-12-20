class PayOfferRequest {
  int? offerId;
  int? hours;

  PayOfferRequest({
    this.offerId,
    this.hours,
  });

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['offerId'] = offerId;
    data['hours'] = hours;
    return data;
  }
}
