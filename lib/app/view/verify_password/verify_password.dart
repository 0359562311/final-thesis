import 'package:fakeslink/app/viewmodel/authentication/verify_password/verify_password_state.dart';
import 'package:fakeslink/app/viewmodel/authentication/verify_password/verify_password_view_model.dart';
import 'package:fakeslink/core/const/app_colors.dart';
import 'package:fakeslink/core/custom_widgets/loading_widget.dart';
import 'package:fakeslink/core/custom_widgets/text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class VerifyPasswordPage extends StatefulWidget {
  const VerifyPasswordPage({Key? key}) : super(key: key);

  @override
  State<VerifyPasswordPage> createState() => _VerifyPasswordPageState();
}

class _VerifyPasswordPageState extends State<VerifyPasswordPage> {
  String _password = "";
  final VerifyPasswordViewModel _viewModel = VerifyPasswordViewModel();

  @override
  void dispose() {
    _viewModel.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Xác thực",
          style: GoogleFonts.montserrat(),
        ),
        centerTitle: true,
        backgroundColor: AppColor.white,
        elevation: 0,
      ),
      body: BlocConsumer<VerifyPasswordViewModel, VerifyPasswordState>(
        bloc: _viewModel,
        listener: (context, state) {
          if (state is VerifyPasswordSuccessState) {
            Navigator.pop(context, true);
          } else if (state is VerifyPasswordErrorState) {
            Navigator.pop(
              context,
            );
          }
        },
        builder: (context, state) {
          if (state is VerifyPasswordLoadingState) {
            return LoadingWidget();
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppTextField(
                hint: "Mật khẩu",
                obscureText: true,
                onChanged: (value) {
                  setState(() {
                    _password = value;
                  });
                },
              ),
              TextButton(
                  onPressed: () {
                    if (_password.isNotEmpty) {
                      _viewModel.auth(_password);
                    }
                  },
                  child: Text(
                    "Xác thực",
                    style: GoogleFonts.montserrat(),
                  ))
            ],
          );
        },
      ),
    );
  }
}
