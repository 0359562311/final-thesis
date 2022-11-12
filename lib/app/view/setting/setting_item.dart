import 'package:fakeslink/core/const/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

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
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [BoxShadow(blurRadius: 0.5, blurStyle: BlurStyle.outer)]),
      child: ListTile(
        leading: Icon(
          icon,
          color: iconColor,
        ),
        title: Text(title),
      ),
    );
  }
}
