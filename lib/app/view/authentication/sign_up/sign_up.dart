import 'package:fakeslink/app/viewmodel/authentication/sign_up/sign_up_cubit.dart';
import 'package:fakeslink/app/viewmodel/authentication/sign_up/sign_up_state.dart';
import 'package:fakeslink/core/const/app_colors.dart';
import 'package:fakeslink/core/custom_widgets/custom_button.dart';
import 'package:fakeslink/core/custom_widgets/text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late final TextEditingController _emailController,
      _passwordController,
      _confirmPasswordController;
  late final SignUpCubit _cubit;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    _cubit = SignUpCubit();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: Theme.of(context).iconTheme.copyWith(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(36.0),
        child: BlocConsumer<SignUpCubit, SignUpState>(
          bloc: _cubit,
          listener: (context, state) {
            if (state is SignUpErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Đăng ký không thành công")));
            } else if (state is SignUpSuccessState) {
              Navigator.pop(context);
            }
          },
          builder: (context, state) {
            return AbsorbPointer(
              absorbing: state is SignUpLoadingState,
              child: Column(
                children: [
                  Center(
                    child: Text(
                      "Đăng ký",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 36,
                  ),
                  AppTextField(
                    hint: "Email",
                    controller: _emailController,
                    errorText: _cubit.errorEmail,
                    onChanged: _cubit.validateEmail,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  AppTextField(
                    hint: "Mật khẩu",
                    obscureText: true,
                    controller: _passwordController,
                    errorText: _cubit.errorPassword,
                    onChanged: (_) {
                      _cubit.validateConfirmPassword(_passwordController.text,
                          _confirmPasswordController.text);
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  AppTextField(
                    hint: "Nhập lại mật khẩu",
                    obscureText: true,
                    controller: _confirmPasswordController,
                    errorText: _cubit.errorConfirmPassword,
                    onChanged: (value) {
                      _cubit.validateConfirmPassword(
                          _passwordController.text, value);
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: state != SignUpLoadingState
                        ? AppButton(
                            title: "Đăng ký",
                            onPressed: () {
                              _cubit.signUp(_emailController.text,
                                  _passwordController.text);
                            },
                          )
                        : SizedBox(
                            height: 33,
                            width: 33,
                            child: CircularProgressIndicator(
                                color: AppColor.secondaryColor),
                          ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
