import 'package:fakeslink/core/const/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class AppButton extends StatelessWidget {
  final Color? backgroundColor;
  final String title;
  final VoidCallback onPressed;
  final double? borderRadius;
  final EdgeInsets? contentPadding;
  const AppButton(
      {Key? key,
      this.backgroundColor,
      required this.title,
      required this.onPressed,
      this.borderRadius,
      this.contentPadding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding:
            contentPadding ?? EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
            color: backgroundColor ?? AppColor.secondaryColor,
            borderRadius: BorderRadius.circular(borderRadius ?? 10)),
        child: Text(
          title,
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w700, fontSize: 12),
        ),
      ),
    );
  }
}
