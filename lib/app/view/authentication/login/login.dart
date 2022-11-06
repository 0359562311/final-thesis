import 'package:fakeslink/app/viewmodel/authentication/login/login_cubit.dart';
import 'package:fakeslink/app/viewmodel/authentication/login/login_state.dart';
import 'package:fakeslink/core/const/app_colors.dart';
import 'package:fakeslink/core/const/app_routes.dart';
import 'package:fakeslink/core/custom_widgets/custom_button.dart';
import 'package:fakeslink/core/custom_widgets/text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final LoginCubit _cubit;
  late final TextEditingController _emailController, _passwordController;

  @override
  void initState() {
    super.initState();
    _cubit = LoginCubit();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _cubit.close();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocConsumer<LoginCubit, LoginState>(
        bloc: _cubit,
        listener: (context, state) {
          if (state.status == LoginStatus.error && state.error != null) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error!)));
          } else if (state.status == LoginStatus.success) {
            Navigator.pushNamed(context, AppRoute.home);
          }
        },
        builder: (context, state) {
          return AbsorbPointer(
            absorbing: state.status == LoginStatus.loading,
            child: Padding(
              padding: const EdgeInsets.all(36),
              child: Column(
                children: [
                  const SizedBox(
                    height: 120,
                  ),
                  Image.asset(
                    "assets/images/logo.png",
                    height: 50,
                    width: 115,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  AppTextField(
                    key: ValueKey("account"),
                    hint: "Tài khoản",
                    errorText: state.errorEmail,
                    onChanged: _cubit.validateEmail,
                    controller: _emailController,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  AppTextField(
                    key: ValueKey("password"),
                    controller: _passwordController,
                    hint: "Mật khẩu",
                    obscureText: true,
                    errorText: state.errorPassword,
                    onChanged: _cubit.validatePassword,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      const Text(
                        "Quên mật khẩu?",
                        style: TextStyle(
                            color: AppColor.secondaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                      const Spacer(),
                      if (state.status != LoginStatus.loading)
                        AppButton(
                          backgroundColor: AppColor.secondaryColor,
                          title: "Đăng nhập",
                          onPressed: () {
                            _cubit.login(_emailController.text,
                                _passwordController.text);
                          },
                        ),
                      if (state.status == LoginStatus.loading)
                        SizedBox(
                          height: 33,
                          width: 33,
                          child: CircularProgressIndicator(
                            color: AppColor.secondaryColor,
                          ),
                        )
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  RichText(
                      text: const TextSpan(children: [
                    TextSpan(
                        text: "Bạn chưa có tài khoản? ",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.black)),
                    WidgetSpan(
                      child: Text(
                        "Đăng ký",
                        style: TextStyle(
                            color: AppColor.secondaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ])),
                  const SizedBox(
                    height: 16,
                  ),
                  const Text(
                    "hoặc đăng nhập với",
                    style: TextStyle(color: Colors.black38, fontSize: 12),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border:
                            Border.all(color: AppColor.background, width: 2)),
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/images/icon_google.png",
                          width: 24,
                          height: 24,
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        const Text(
                          "Tài khoản Google",
                          style: TextStyle(color: Colors.black38),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
