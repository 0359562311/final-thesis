import 'package:fakeslink/app/viewmodel/home/home_cubit.dart';
import 'package:fakeslink/app/viewmodel/home/home_state.dart';
import 'package:fakeslink/core/const/app_colors.dart';
import 'package:fakeslink/core/custom_widgets/circle_avatar_widget.dart';
import 'package:fakeslink/core/utils/extensions/num.dart';
import 'package:fakeslink/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../model/entities/user.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  late HomeCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = HomeCubit();
    _cubit.init();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      bloc: _cubit,
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: SizedBox(
                height: 36,
              ),
            ),
            SliverToBoxAdapter(
              child: Image.asset(
                "assets/images/logo.png",
                height: 44,
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 16,
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    Text("Xin chào, ${configBox.get("user")?.name}!"),
                    Spacer(),
                    AvatarWidget(
                      avatar: configBox.get("user").avatar,
                      size: 32,
                    )
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 16,
              ),
            ),
            SliverToBoxAdapter(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Text(
                    "Công việc hot nhất",
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.bold,
                      fontSize: 26,
                    ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 40,
                child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    scrollDirection: Axis.horizontal,
                    itemCount: _cubit.state.category?.length,
                    itemBuilder: (context, index) {
                      return Center(
                        child: GestureDetector(
                          onTap: () {
                            _cubit.changeTab(index);
                          },
                          child: Container(
                              margin: EdgeInsets.only(right: 5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                      color: _cubit.state.currentTab == index
                                          ? AppColor.primaryColor
                                          : Colors.grey.withOpacity(0.3))),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 3),
                              child: Text(
                                _cubit.state.category?[index].name ?? "",
                                style: GoogleFonts.montserrat(
                                  color: AppColor.primaryColor,
                                ),
                              )),
                        ),
                      );
                    }),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 96,
                child: ListView.builder(
                  itemCount: state.jobs?.length ?? 0,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final job = state.jobs![index];
                    return Container(
                      margin: EdgeInsets.only(left: 10, right: 6),
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColor.primaryColor10,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 56,
                            height: 56,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: AppColor.primaryColor),
                            child: Icon(
                              Icons.translate,
                              color: AppColor.white,
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                job.title ?? "",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.montserrat(
                                    color: AppColor.primaryColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "${(job.payment?.amount ?? 0).price} VND",
                                style: GoogleFonts.montserrat(
                                    color: AppColor.errorColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal),
                              ),
                              Text(
                                job.payment?.paymentMethod?.id == 1
                                    ? "Trả theo dự án"
                                    : "Trả theo giờ",
                                style: GoogleFonts.montserrat(
                                    color: AppColor.primaryColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal),
                              ),
                              Text(
                                "Việc làm từ xa",
                                style: GoogleFonts.montserrat(
                                    color: AppColor.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal),
                              )
                            ],
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: 12),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                child: Text(
                  "Đăng việc",
                  style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.bold, fontSize: 24),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  "Chọn 1 loại công việc để đăng",
                  style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.normal, fontSize: 12),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                height: MediaQuery.of(context).size.width,
                margin: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: AppColor.white,
                    borderRadius: BorderRadius.circular(10)),
                child: GridView.builder(
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3),
                    itemCount: 9,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: AppColor.background,
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                _cubit.listImage[index],
                                height: 32,
                                width: 32,
                                color: AppColor.primaryColor,
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Text(
                                _cubit.listJob[index],
                                style: GoogleFonts.montserrat(
                                    color: AppColor.primaryColor,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
              ),
            )
          ],
        );
      },
    );
  }
}
