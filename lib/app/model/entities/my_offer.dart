class MyOffer {
  int? id;
  String? status;
  int? price;
  String? description;
  int? job;
  int? user;

  MyOffer({
    this.id,
    this.status,
    this.price,
    this.description,
    this.job,
    this.user,
  });
  MyOffer.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    status = json['status']?.toString();
    price = json['price']?.toInt();
    description = json['description']?.toString();
    job = json['job']?.toInt();
    user = json['user']?.toInt();
  }
}
