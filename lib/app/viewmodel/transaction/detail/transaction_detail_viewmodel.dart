import 'package:fakeslink/app/model/repositories/transaction_repository.dart';
import 'package:fakeslink/app/viewmodel/transaction/detail/transaction_detail_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionDetailViewModel extends Cubit<TransactionDetailState> {
  final TransactionRepository _repository = TransactionRepositoryImpl();

  TransactionDetailViewModel()
      : super(TransactionDetailState(status: TransactionDetailStatus.loading));

  void init(int id) {
    emit(state.copyWith(status: TransactionDetailStatus.loading));
    _repository.getById(id).then((value) {
      emit(
          state.copyWith(data: value, status: TransactionDetailStatus.success));
    }).catchError((_) {
      emit(state.copyWith(status: TransactionDetailStatus.error));
    });
  }
}
