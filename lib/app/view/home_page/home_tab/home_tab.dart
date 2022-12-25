import 'package:fakeslink/app/view/create_job/create_job.dart';
import 'package:fakeslink/app/view/verify_password/verify_password.dart';
import 'package:fakeslink/app/view/job_detail/job_detail.dart';
import 'package:fakeslink/app/viewmodel/home/home_tab/home_cubit.dart';
import 'package:fakeslink/app/viewmodel/home/home_tab/home_state.dart';
import 'package:fakeslink/core/const/app_colors.dart';
import 'package:fakeslink/core/const/app_routes.dart';
import 'package:fakeslink/core/custom_widgets/circle_avatar_widget.dart';
import 'package:fakeslink/core/utils/extensions/num.dart';
import 'package:fakeslink/main.dart';
import 'package:fakeslink/core/utils/navigations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab>
    with AutomaticKeepAliveClientMixin<HomeTab> {
  late HomeViewModel _cubit;
  String deposit = "0";
  String withdraw = "0";
  late TextEditingController _depositController, _withdrawController;
  final RefreshController _refreshController = RefreshController();

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of(context);
    _cubit.init();
    _depositController = TextEditingController();
    _withdrawController = TextEditingController();
  }

  @override
  void dispose() {
    _depositController.dispose();
    _withdrawController.dispose();
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeViewModel, HomeState>(
      bloc: _cubit,
      listener: (context, state) {
        if (state.status == HomeStatus.depositSuccess ||
            state.status == HomeStatus.withdrawSuccess) {
          Navigator.pushNamed(context, AppRoute.transactionDetail,
              arguments: state.transaction?.id ?? 0);
        }
      },
      builder: (context, state) {
        return SmartRefresher(
          controller: _refreshController,
          onRefresh: () {
            _cubit.init();
            _refreshController.refreshCompleted();
          },
          child: CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(
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
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 16,
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      Text(
                        "Xin chào, ${configBox.get("user")?.name}!",
                        style: GoogleFonts.montserrat(),
                      ),
                      const Spacer(),
                      AvatarWidget(
                        avatar: configBox.get("user")?.avatar,
                        size: 40,
                      )
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Row(
                  children: [
                    const SizedBox(
                      width: 16,
                    ),
                    Text("Tài khoản: ", style: GoogleFonts.montserrat()),
                    Text(
                        ((configBox.get("user")?.balance ?? 0) as int).price +
                            " VND",
                        style: GoogleFonts.montserrat(
                            fontSize: 18,
                            color: AppColor.primaryColor,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              SliverToBoxAdapter(
                child: Row(
                  children: [
                    const SizedBox(
                      width: 16,
                    ),
                    TextButton(
                      onPressed: () async {
                        final data = await Navigator.push(context,
                            MaterialPageRoute(builder: (_) {
                          return const VerifyPasswordPage();
                        }));
                        if (data != true) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Xác thực không thành công.")));
                          return;
                        }
                        showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return IntrinsicHeight(
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                            child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: TextField(
                                            autofocus: true,
                                            keyboardType: TextInputType.number,
                                            onChanged: (value) {
                                              deposit = value;
                                            },
                                          ),
                                        )),
                                        TextButton(
                                            onPressed: () {
                                              int amount = int.parse(deposit);
                                              if (amount > 0) {
                                                Navigator.pop(context);
                                                _cubit.deposit(amount);
                                              }
                                            },
                                            style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        AppColor.primaryColor)),
                                            child: Text(
                                              "Nạp",
                                              style: GoogleFonts.montserrat(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ))
                                      ],
                                    ),
                                    SizedBox(
                                      height: MediaQuery.of(context)
                                              .viewInsets
                                              .bottom +
                                          MediaQuery.of(context).padding.bottom,
                                    )
                                  ],
                                ),
                              );
                            });
                      },
                      child: Text(
                        "Nạp tiền",
                        style: GoogleFonts.montserrat(
                            color: AppColor.primaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    TextButton(
                      onPressed: () async {
                        if (configBox.get('user')?.bankAccount == null) {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text(
                                  "Hãy cập nhật tài khoản ngân hàng của bạn")));
                          return;
                        }
                        final data = await Navigator.push(context,
                            MaterialPageRoute(builder: (_) {
                          return const VerifyPasswordPage();
                        }));
                        if (data != true) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Xác thực không thành công.")));
                          return;
                        }
                        showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return IntrinsicHeight(
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                            child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: TextField(
                                            autofocus: true,
                                            keyboardType: TextInputType.number,
                                            onChanged: (value) {
                                              deposit = value;
                                            },
                                          ),
                                        )),
                                        TextButton(
                                            onPressed: () {
                                              int amount = int.parse(deposit);
                                              if (amount > 0) {
                                                Navigator.pop(context);
                                                _cubit.withdraw(amount);
                                              }
                                            },
                                            style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        AppColor.primaryColor)),
                                            child: Text(
                                              "Rút",
                                              style: GoogleFonts.montserrat(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ))
                                      ],
                                    ),
                                    SizedBox(
                                      height: MediaQuery.of(context)
                                              .viewInsets
                                              .bottom +
                                          MediaQuery.of(context).padding.bottom,
                                    )
                                  ],
                                ),
                              );
                            });
                      },
                      child: Text("Rút tiền",
                          style: GoogleFonts.montserrat(
                              color: AppColor.primaryColor,
                              fontWeight: FontWeight.bold)),
                    ),
                  ],
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
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      scrollDirection: Axis.horizontal,
                      itemCount: _cubit.state.category?.length,
                      itemBuilder: (context, index) {
                        return Center(
                          child: GestureDetector(
                            onTap: () {
                              _cubit.changeTab(index);
                            },
                            child: Container(
                                margin: const EdgeInsets.only(right: 5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                        color: _cubit.state.currentTab == index
                                            ? AppColor.primaryColor
                                            : Colors.grey.withOpacity(0.3))),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 3),
                                child: Text(
                                  _cubit.state.category?[index].name ?? "",
                                  style: GoogleFonts.montserrat(
                                      color: _cubit.state.currentTab == index
                                          ? AppColor.primaryColor
                                          : null),
                                )),
                          ),
                        );
                      }),
                ),
              ),
              if (state.jobs?.isNotEmpty ?? false)
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 96,
                    child: ListView.builder(
                      itemCount: state.jobs?.length ?? 0,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final job = state.jobs![index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => JobDetailPage(
                                      jobId: _cubit.state.jobs?[index].id,
                                      categoryId: _cubit.categoryId,
                                    )));
                          },
                          child: Container(
                            margin: const EdgeInsets.only(left: 10, right: 6),
                            padding: const EdgeInsets.all(16),
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
                                  child: const Icon(
                                    CupertinoIcons.bag,
                                    color: AppColor.white,
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      constraints: const BoxConstraints(
                                          maxWidth: 200, minWidth: 0),
                                      child: Text(
                                        job.title ?? "",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.montserrat(
                                            color: AppColor.primaryColor,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
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
                          ),
                        );
                      },
                    ),
                  ),
                ),
              if (state.jobs?.isEmpty ?? false)
                SliverToBoxAdapter(
                  child: Center(
                      child: Text(
                    "Không có công việc nào!",
                    style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: AppColor.primaryColor),
                  )),
                ),
              const SliverToBoxAdapter(
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
                  margin: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: AppColor.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: GridView.builder(
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3),
                      itemCount: 9,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            NavigationUtils.navigatePage(
                                context, const CreateJobPage());
                          },
                          child: Container(
                            margin: const EdgeInsets.all(10),
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
                                  const SizedBox(
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
                          ),
                        );
                      }),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
