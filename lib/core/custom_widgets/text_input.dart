import 'package:fakeslink/core/const/app_colors.dart';
import 'package:flutter/material.dart';

class AppTextField extends StatefulWidget {
  final String? errorText;
  final String hint;
  final double? maxHeight;
  final double? width;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final bool obscureText;
  final TextEditingController? controller;
  const AppTextField(
      {Key? key,
      this.errorText,
      required this.hint,
      this.maxHeight,
      this.width,
      this.onChanged,
      this.onSubmitted,
      this.obscureText = false,
      this.controller})
      : super(key: key);

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      onChanged: widget.onChanged,
      onSubmitted: widget.onSubmitted,
      obscureText: widget.obscureText,
      decoration: InputDecoration(
          fillColor: AppColor.background,
          filled: true,
          contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          hintText: widget.hint,
          errorText: widget.errorText,
          hintStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black38,
              fontStyle: FontStyle.italic),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: AppColor.background)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: AppColor.background)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: AppColor.errorColor)),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: AppColor.errorColor))),
    );
  }
}
