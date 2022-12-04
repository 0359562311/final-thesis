import 'package:fakeslink/app/model/entities/category.dart';
import 'package:fakeslink/app/model/entities/payment.dart';

enum CreateJobStatus {
  loading,
  success,
  error,
  updateImageSuccess,
  createJobSuccess
}

class CreateJobState {
  final CreateJobStatus status;
  final List<Category>? category;
  final List<PaymentMethod>? payment;

  CreateJobState({required this.status, this.category, this.payment});

  CreateJobState copyWith(
      {CreateJobStatus? status,
      List<Category>? category,
      List<PaymentMethod>? payment}) {
    return CreateJobState(
        status: status ?? this.status,
        category: category ?? this.category,
        payment: payment ?? this.payment);
  }
}
