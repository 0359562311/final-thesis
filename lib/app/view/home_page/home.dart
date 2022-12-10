import 'package:fakeslink/app/view/home_page/activities/activities_page.dart';
import 'package:fakeslink/app/view/home_page/jobs_list/jobs_list_page.dart';
import 'package:fakeslink/app/view/notification/notification.dart';
import 'package:fakeslink/app/view/setting/setting.dart';
import 'package:fakeslink/core/const/app_colors.dart';
import 'package:flutter/material.dart';

import 'home_tab/home_tab.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final PageController _pageController = PageController(initialPage: 0);

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
          textTheme: Theme.of(context)
              .textTheme
              .apply(displayColor: AppColor.black, bodyColor: AppColor.black)),
      child: Scaffold(
        body: PageView(
          controller: _pageController,
          children: [
            HomeTab(),
            ActivitiesPage(),
            JobsListPage(),
            NotificationPage(),
            SettingTab()
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: AppColor.white,
          selectedItemColor: AppColor.primaryColor,
          unselectedItemColor: AppColor.primaryColor.withOpacity(0.2),
          selectedIconTheme: IconThemeData(color: AppColor.primaryColor),
          unselectedIconTheme:
              IconThemeData(color: AppColor.primaryColor, opacity: 0.2),
          currentIndex: _currentIndex,
          onTap: (value) {
            setState(() {
              _currentIndex = value;
              _pageController.jumpToPage(
                _currentIndex,
              );
            });
          },
          items: [
            BottomNavigationBarItem(
                icon: Image.asset(
                  "assets/images/ic_home.png",
                  color: AppColor.primaryColor,
                  width: 24,
                  height: 24,
                ),
                label: "Trang chủ"),
            BottomNavigationBarItem(
                icon: Image.asset(
                  "assets/images/ic_job_history.png",
                  width: 24,
                  height: 24,
                ),
                label: "Hoạt động"),
            BottomNavigationBarItem(
                icon: Image.asset(
                  "assets/images/ic_job_list.png",
                  width: 24,
                  height: 24,
                ),
                label: "Công việc"),
            BottomNavigationBarItem(
                icon: Image.asset(
                  "assets/images/ic_notification.png",
                  width: 24,
                  height: 24,
                ),
                label: "Thông báo"),
            BottomNavigationBarItem(
                icon: Image.asset(
                  "assets/images/ic_setting.png",
                  width: 24,
                  height: 24,
                ),
                label: "Cài đặt"),
          ],
        ),
      ),
    );
  }
}
