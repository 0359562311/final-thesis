import 'package:fakeslink/core/const/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

AppBar appBar(BuildContext context, String title,
    {Widget? leadingWidget,
    Widget? rightWidget,
    Color? backgroundColor,
    Color? iconColor,
    Color? textColor,
    double? elevation,
    bool centerTitle = false}) {
  return AppBar(
    backgroundColor: backgroundColor ?? Colors.white,
    centerTitle: centerTitle,
    elevation: elevation ?? 0,
    leadingWidth: 60,
    titleSpacing: 0,
    leading: leadingWidget ??
        (Navigator.of(context).canPop() == true
            ? IconButton(
                onPressed: () => Navigator.of(context).maybePop(),
                icon: Icon(
                  CupertinoIcons.arrow_left,
                  color: iconColor ?? Colors.black,
                ))
            : null),
    iconTheme: IconThemeData(color: iconColor ?? Colors.black),
    title: Text(
      title,
      textAlign: TextAlign.center,
      style: GoogleFonts.montserrat(
          color: textColor ?? AppColor.white,
          fontWeight: FontWeight.w600,
          fontSize: 20),
    ),
    actions: rightWidget == null ? null : [rightWidget],
  );
}
