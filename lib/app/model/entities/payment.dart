class Payment {
  final int? id;
  final PaymentMethod? paymentMethod;
  final int? amount;

  Payment({
    this.id,
    this.paymentMethod,
    this.amount,
  });

  Payment.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        paymentMethod = (json['paymentMethod'] as Map<String, dynamic>?) != null
            ? PaymentMethod.fromJson(
                json['paymentMethod'] as Map<String, dynamic>)
            : null,
        amount = json['amount'] as int?;

  Map<String, dynamic> toJson() =>
      {'id': id, 'paymentMethod': paymentMethod?.toJson(), 'amount': amount};
}

class PaymentMethod {
  final int? id;
  final String? title;
  final String? description;

  PaymentMethod({
    this.id,
    this.title,
    this.description,
  });

  PaymentMethod.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        title = json['title'] as String?,
        description = json['description'] as String?;

  Map<String, dynamic> toJson() =>
      {'id': id, 'title': title, 'description': description};
}
