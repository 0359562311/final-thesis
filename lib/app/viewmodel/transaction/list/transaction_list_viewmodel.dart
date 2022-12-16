import 'package:fakeslink/app/model/repositories/transaction_repository.dart';
import 'package:fakeslink/app/viewmodel/transaction/list/transaction_list_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionListViewModel extends Cubit<TransactionListState> {
  final TransactionRepository _repository = TransactionRepositoryImpl();
  TransactionListViewModel()
      : super(TransactionListState(
            data: [],
            offset: 0,
            hasMore: true,
            status: TransactionListStatus.loading));

  void getTransaction([bool isRefresh = false]) {
    if (state.data.isEmpty) {
      emit(state.copyWith(status: TransactionListStatus.loading));
    }
    if (isRefresh) {
      state.offset = 0;
    }
    _repository.getAll(state.offset).then((value) {
      if (isRefresh) {
        state.data.clear();
      }
      state.data.addAll(value);
      emit(state.copyWith(
          status: TransactionListStatus.success,
          offset: state.offset + value.length,
          hasMore: value.length == 20));
    }).catchError((_) {
      state.data.clear();
      emit(state.copyWith(status: TransactionListStatus.error, hasMore: true));
    });
  }
}
