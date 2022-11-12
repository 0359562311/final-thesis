import 'package:fakeslink/app/view/setting/setting_item.dart';
import 'package:fakeslink/core/const/app_colors.dart';
import 'package:fakeslink/core/const/app_routes.dart';
import 'package:flutter/material.dart';

class SettingTab extends StatefulWidget {
  const SettingTab({Key? key}) : super(key: key);

  @override
  State<SettingTab> createState() => _SettingTabState();
}

class _SettingTabState extends State<SettingTab> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          SizedBox(
            height: 16,
          ),
          Row(
            children: [
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, AppRoute.profile, arguments: 1);
                },
                child: CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(
                      "https://znews-photo.zingcdn.me/w660/Uploaded/kbd_pilk/2022_08_30/lisa67.jpg"),
                ),
              ),
              SizedBox(
                width: 16,
              ),
              Expanded(child: Text("anhtanhangxom@gmail.com")),
              SizedBox(
                width: 16,
              ),
              IconButton(onPressed: () {}, icon: Icon(Icons.edit_note))
            ],
          ),
          SizedBox(
            height: 32,
          ),
          SettingItem(
              icon: Icons.notifications,
              iconColor: AppColor.primaryColor,
              title: "Thông báo"),
          SizedBox(
            height: 8,
          ),
          SettingItem(
              icon: Icons.attach_money,
              iconColor: AppColor.primaryColor,
              title: "Lịch sử giao dịch"),
          SizedBox(
            height: 8,
          ),
          SettingItem(
              icon: Icons.mode_standby,
              iconColor: AppColor.primaryColor,
              title: "Thay đổi tài khoản ngân hàng"),
          SizedBox(
            height: 8,
          ),
          SettingItem(
              icon: Icons.question_mark,
              iconColor: AppColor.primaryColor,
              title: "Về ứng dụng"),
          SizedBox(
            height: 8,
          ),
          SettingItem(
              icon: Icons.support_agent,
              iconColor: AppColor.primaryColor,
              title: "Hỗ trợ khách hàng"),
          SizedBox(
            height: 40,
          ),
          SettingItem(
              icon: Icons.logout,
              iconColor: AppColor.primaryColor,
              title: "Đăng xuất"),
          SizedBox(
            height: 8,
          ),
        ],
      ),
    ));
  }
}
