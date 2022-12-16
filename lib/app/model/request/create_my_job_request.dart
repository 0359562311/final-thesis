class CreateMyJobRequest {
  int? price;
  String? description;

  CreateMyJobRequest({
    this.price,
    this.description,
  });

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['price'] = price;
    data['description'] = description;
    return data;
  }
}
