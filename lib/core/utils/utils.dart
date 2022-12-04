import 'dart:convert';

import 'package:fakeslink/core/const/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Utils {
  static Future<Map<String, dynamic>> parseJson(String fileName) async {
    return jsonDecode(await rootBundle.loadString(fileName));
  }

  static bool isEmpty(Object? text) {
    if (text is String) return text.isEmpty;
    if (text is List) return text.isEmpty;
    return text == null;
  }

  static void showSnackBar(context, String content) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(milliseconds: 2000),
        backgroundColor: AppColor.primaryColor,
        content: Text(
          content,
          style: Theme.of(context).textTheme.button!.copyWith(
                color: Colors.white,
              ),
        ),

        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
        behavior: SnackBarBehavior.floating, // Add this line
      ),
    );
  }
}
