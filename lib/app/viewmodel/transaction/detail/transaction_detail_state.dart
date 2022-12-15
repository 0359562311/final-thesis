import 'package:fakeslink/app/model/entities/transaction.dart';

class TransactionDetailState {
  final Transaction? data;
  final TransactionDetailStatus status;
  TransactionDetailState({
    this.data,
    required this.status,
  });

  TransactionDetailState copyWith({
    Transaction? data,
    TransactionDetailStatus? status,
  }) {
    return TransactionDetailState(
      data: data ?? this.data,
      status: status ?? this.status,
    );
  }
}

enum TransactionDetailStatus { success, error, loading }
