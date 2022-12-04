import 'package:fakeslink/core/const/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class ButtonWidget extends StatelessWidget {
  final double? height;
  final double? width;
  final Color? backgroundColor;
  final Color? textColor;
  final double? textSize;
  final Color? borderColor;
  final String title;
  final VoidCallback? onPressed;
  final double? radius;
  final bool modeFlatButton;
  final bool uppercaseTitle;
  final bool showCircleIndicator;
  final EdgeInsetsGeometry? padding;
  final TextStyle? textStyle;

  ButtonWidget(
      {this.backgroundColor,
      this.textColor,
      this.borderColor,
      this.height,
      this.width,
      this.padding,
      this.textSize,
      required this.title,
      required this.onPressed,
      this.radius,
      this.modeFlatButton: true,
      this.uppercaseTitle: true,
      this.showCircleIndicator: false,
      this.textStyle});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: height,
        width: width,
//        color: backgroundColor,
        alignment: Alignment.center,
        padding: padding ?? EdgeInsets.symmetric(vertical: 0),
        decoration: BoxDecoration(
            color: onPressed != null
                ? (backgroundColor ?? AppColor.primaryColor)
                : AppColor.primaryColor,
//            gradient: LinearGradient(
//              colors: [Theme.of(context).primaryColor, Colors.lightBlue],
//            ),
            border: Border.all(
                color: onPressed != null
                    ? (borderColor ?? backgroundColor ?? Colors.transparent)
                    : AppColor.primaryColor,
                width: 1),
            borderRadius: BorderRadius.circular(radius ?? 48)),
        child: showCircleIndicator
            ? Center(
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(),
                ),
              )
            : Text(
                uppercaseTitle ? title.toUpperCase().trim() : title.trim(),
                maxLines: 1,
                textAlign: TextAlign.center,
                style: textStyle ??
                    GoogleFonts.montserrat(
                        fontSize: textSize ?? 16,
                        fontWeight: FontWeight.w600,
                        color: textColor ?? AppColor.white,
                        height: 1),
              ),
      ),
    );
  }
}
