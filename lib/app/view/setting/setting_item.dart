import 'package:fakeslink/core/const/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingItem extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final VoidCallback? onPressed;
  const SettingItem(
      {Key? key,
      required this.icon,
      required this.iconColor,
      required this.title,
      this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: AppColor.primaryColor.withOpacity(0.3),
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          leading: Icon(
            icon,
            color: iconColor,
          ),
          title: Text(
            title,
            style: GoogleFonts.montserrat(
                color: AppColor.primaryColor, fontSize: 14),
          ),
        ),
      ),
    );
  }
}
