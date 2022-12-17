import 'package:fakeslink/app/model/entities/user.dart';
import 'package:fakeslink/app/model/repositories/user_respository.dart';
import 'package:fakeslink/app/model/request/update_bank_account_request.dart';
import 'package:fakeslink/app/viewmodel/profile/update_bank_account/update_bank_account_state.dart';
import 'package:fakeslink/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../model/entities/bank.dart';

class UpdateBankAccountViewModel extends Cubit<UpdateBankAccountState> {
  final UserRepository _userRepository = UserRepositoryImpl();

  List<Bank> banks = [];

  UpdateBankAccountViewModel()
      : super(UpdateBankAccountState(status: UpdateBankAccountStatus.initial));

  void getBanks() {
    _userRepository.getBanks().then((value) {
      banks = value;
      bool preset = value.any((element) =>
          element.id == configBox.get('user')?.bankAccount?.bank?.id);
      emit(state.copyWith(
          status: UpdateBankAccountStatus.success,
          selectedBank: preset
              ? value.firstWhere((element) =>
                  element.id == configBox.get('user')?.bankAccount?.bank?.id)
              : null));
    }).catchError((_) {
      emit(state.copyWith(status: UpdateBankAccountStatus.error));
    });
  }

  void selectBank(Bank bank) {
    emit(state.copyWith(selectedBank: bank));
  }

  void update(String accountName, String accountNumber) {
    if (state.selectedBank != null) {
      emit(state.copyWith(status: UpdateBankAccountStatus.loading));
      _userRepository
          .updateBankAccount(UpdateBankAccountRequest(
              owner: accountName,
              accountNumber: accountNumber,
              bank: state.selectedBank!.id!))
          .then((value) {
        emit(state.copyWith(status: UpdateBankAccountStatus.updateSuccess));
      }).catchError((_) {
        emit(state.copyWith(status: UpdateBankAccountStatus.error));
      });
    }
  }
}
