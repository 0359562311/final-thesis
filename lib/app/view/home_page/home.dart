import 'package:fakeslink/app/view/home_page/activities/activities_page.dart';
import 'package:fakeslink/app/view/home_page/jobs_list/jobs_list_page.dart';
import 'package:fakeslink/app/view/notification/notification.dart';
import 'package:fakeslink/app/view/setting/setting.dart';
import 'package:fakeslink/app/viewmodel/home/home_tab/home_cubit.dart';
import 'package:fakeslink/core/const/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  void initState() {
    super.initState();
  }

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
                icon: Icon(
                  Icons.home_rounded,
                  size: 28,
                ),
                label: "Trang chủ"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.list,
                  size: 28,
                ),
                label: "Hoạt động"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.shopping_bag_rounded,
                  size: 28,
                ),
                label: "Công việc"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.notifications,
                  size: 28,
                ),
                label: "Thông báo"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.settings,
                  size: 28,
                ),
                label: "Cài đặt"),
          ],
        ),
      ),
    );
  }
}
