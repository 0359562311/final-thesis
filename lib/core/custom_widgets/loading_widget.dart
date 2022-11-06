import 'package:fakeslink/core/const/app_colors.dart';
import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
                child: CircularProgressIndicator(
                  color: AppColor.black,
                  strokeWidth: 5,
                ),
              );
  }
}