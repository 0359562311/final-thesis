import 'package:fakeslink/app/model/entities/transaction.dart';

enum TransactionListStatus { error, loading, success }

class TransactionListState {
  List<Transaction> data;
  int offset;
  bool hasMore;
  TransactionListStatus status;
  TransactionListState({
    required this.data,
    required this.offset,
    required this.hasMore,
    required this.status,
  });

  TransactionListState copyWith({
    List<Transaction>? data,
    int? offset,
    bool? hasMore,
    TransactionListStatus? status,
  }) {
    return TransactionListState(
      data: data ?? this.data,
      offset: offset ?? this.offset,
      hasMore: hasMore ?? this.hasMore,
      status: status ?? this.status,
    );
  }
}
