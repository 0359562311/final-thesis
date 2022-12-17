import 'package:fakeslink/app/model/entities/bank.dart';

enum UpdateBankAccountStatus { error, loading, success, initial, updateSuccess }

class UpdateBankAccountState {
  UpdateBankAccountStatus status;
  Bank? selectedBank;
  UpdateBankAccountState({
    required this.status,
    this.selectedBank,
  });

  UpdateBankAccountState copyWith({
    UpdateBankAccountStatus? status,
    Bank? selectedBank,
  }) {
    return UpdateBankAccountState(
      status: status ?? this.status,
      selectedBank: selectedBank ?? this.selectedBank,
    );
  }
}
