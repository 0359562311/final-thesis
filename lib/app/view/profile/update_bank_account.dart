import 'package:fakeslink/app/model/entities/bank.dart';
import 'package:fakeslink/app/viewmodel/profile/update_bank_account/update_bank_account_state.dart';
import 'package:fakeslink/app/viewmodel/profile/update_bank_account/update_bank_account_viewmodel.dart';
import 'package:fakeslink/core/const/app_colors.dart';
import 'package:fakeslink/core/custom_widgets/loading_widget.dart';
import 'package:fakeslink/core/custom_widgets/text_input.dart';
import 'package:fakeslink/core/utils/utils.dart';
import 'package:fakeslink/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class UpdateBankAccountPage extends StatefulWidget {
  const UpdateBankAccountPage({Key? key}) : super(key: key);

  @override
  State<UpdateBankAccountPage> createState() => _UpdateBankAccountPageState();
}

class _UpdateBankAccountPageState extends State<UpdateBankAccountPage> {
  TextEditingController _accountName =
      TextEditingController(text: configBox.get('user')?.bankAccount?.owner);
  TextEditingController _accountNumber = TextEditingController(
      text: configBox.get('user')?.bankAccount?.accountNumber);
  final UpdateBankAccountViewModel _viewModel = UpdateBankAccountViewModel();

  @override
  void initState() {
    super.initState();
    _viewModel.getBanks();
  }

  @override
  void dispose() {
    _accountName.dispose();
    _accountNumber.dispose();
    _viewModel.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColor.white,
        iconTheme: Theme.of(context).iconTheme.copyWith(color: AppColor.black),
        elevation: 0,
        title: Text(
          "Cập nhật tài khoản ngân hàng",
          style: GoogleFonts.montserrat(
              color: AppColor.primaryColor,
              fontSize: 16,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocConsumer<UpdateBankAccountViewModel, UpdateBankAccountState>(
        bloc: _viewModel,
        listener: (context, state) {
          if (state.status == UpdateBankAccountStatus.error) {
            Utils.showSnackBar(context, "Đã có lỗi xảy ra.");
          } else if (state.status == UpdateBankAccountStatus.updateSuccess) {
            Utils.showSnackBar(context, "Cập nhật thành công.");
            Navigator.pop(context, true);
          }
        },
        builder: (context, state) {
          if (state.status == UpdateBankAccountStatus.loading) {
            return LoadingWidget();
          }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DropdownButton(
                    items: _viewModel.banks.map((e) {
                      return DropdownMenuItem<Bank>(
                        child: Text(e.name ?? ""),
                        value: e,
                      );
                    }).toList(),
                    value: state.selectedBank,
                    hint: Text("Chọn ngân hàng"),
                    onChanged: (Bank? value) {
                      if (value != null) _viewModel.selectBank(value);
                    }),
                AppTextField(
                  hint: "Tên chủ thẻ",
                  controller: _accountName,
                  onChanged: (value) {
                    setState(() {});
                  },
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  "Tên chủ thẻ phải giống tên được in trên thẻ ngân hàng",
                  style: GoogleFonts.montserrat(fontStyle: FontStyle.italic),
                ),
                SizedBox(
                  height: 16,
                ),
                AppTextField(
                  hint: "Số tài khoản",
                  controller: _accountNumber,
                  onChanged: (value) {
                    setState(() {});
                  },
                ),
                SizedBox(
                  height: 16,
                ),
                Center(
                  child: TextButton(
                      onPressed: _isEnabled
                          ? () {
                              _viewModel.update(
                                  _accountName.text, _accountNumber.text);
                            }
                          : null,
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(_isEnabled
                              ? AppColor.primaryColor
                              : AppColor.background)),
                      child: Text(
                        "Cập nhật",
                        style: GoogleFonts.montserrat(color: AppColor.white),
                      )),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  bool get _isEnabled =>
      _accountName.text.isNotEmpty &&
      _accountNumber.text.isNotEmpty &&
      _viewModel.state.selectedBank != null;
}
