import 'package:fakeslink/app/view/profile/certificate_degree_item.dart';
import 'package:fakeslink/app/view/verify_password/verify_password.dart';
import 'package:fakeslink/app/viewmodel/profile/view_profile/view_profile_state.dart';
import 'package:fakeslink/app/viewmodel/profile/view_profile/view_profile_viewmodel.dart';
import 'package:fakeslink/core/const/app_colors.dart';
import 'package:fakeslink/core/custom_widgets/circle_avatar_widget.dart';
import 'package:fakeslink/core/utils/utils.dart';
import 'package:fakeslink/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class UserProfilePage extends StatefulWidget {
  final int? userId;

  const UserProfilePage({Key? key, required this.userId}) : super(key: key);

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  late ViewProfileViewModel _cubit;
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _cubit = ViewProfileViewModel();
    _cubit.getProfile(widget.userId);
    _cubit.getReview(widget.userId ?? configBox.get("user").id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: Theme.of(context).iconTheme.copyWith(color: Colors.black),
      ),
      backgroundColor: Colors.white,
      body: BlocConsumer<ViewProfileViewModel, ViewProfileState>(
        bloc: _cubit,
        listener: (context, state) {
          if (state.status == ViewProfileStatus.inputDaySuccess) {
            _cubit.getProfile(widget.userId);
          }
        },
        builder: (context, state) {
          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Stack(
                  children: [
                    Column(
                      children: [
                        AvatarWidget(
                            avatar: configBox.get("user").avatar, size: 80),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              _cubit.state.data?.name ?? "",
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.edit,
                                  size: 16,
                                  color: AppColor.secondaryColor,
                                ))
                          ],
                        ),
                      ],
                    ),
                    if (_cubit.state.data?.profilePromotion == null)
                    Positioned(
                        bottom: 40,
                        right: 10,
                        child: GestureDetector(
                          onTap: () async {
                            final data = await Navigator.push(context,
                                MaterialPageRoute(builder: (_) {
                              return const VerifyPasswordPage();
                            }));
                            if (data == true) {
                              buildInputDay(context);
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 3),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: AppColor.primaryColor,
                                border:
                                    Border.all(color: AppColor.primaryColor)),
                            child: Text(
                              "Đẩy quảng cáo",
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: Colors.white),
                            ),
                          ),
                        ))
                  ],
                ),
              ),
              if (_cubit.state.data?.profilePromotion?.dueDate != null)
                SliverToBoxAdapter(
                  child: Text(
                    "Hồ sơ cá nhân được quảng cáo tới ${DateFormat("dd/MM/yyyy").format(DateTime.parse(_cubit.state.data?.profilePromotion?.dueDate ?? ""))}",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w600, fontSize: 14),
                  ),
                ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        "Giới thiệu",
                        style:
                            GoogleFonts.montserrat(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        configBox.get("user").bio ?? "Chưa cập nhật",
                        style: GoogleFonts.montserrat(fontSize: 13),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        "Số điện thoại",
                        style:
                            GoogleFonts.montserrat(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        _cubit.state.data?.phoneNumber ?? "Chưa cập nhật",
                        style: GoogleFonts.montserrat(
                            fontSize: 13, color: AppColor.secondaryColor),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        "Email",
                        style:
                            GoogleFonts.montserrat(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        _cubit.state.data?.email ?? "",
                        style: GoogleFonts.montserrat(
                            fontSize: 13, color: AppColor.secondaryColor),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        "Chứng chỉ",
                        style:
                            GoogleFonts.montserrat(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              SliverPadding(
                sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                  return CertificateDegreeItem(
                      title:
                          "${_cubit.state.data?.certificates?[index]?.title}",
                      description:
                          "${_cubit.state.data?.certificates?[index]?.from} - ${_cubit.state.data?.certificates?[index]?.to} ",
                      organization:
                          "${_cubit.state.data?.certificates?[index]?.description}");
                }, childCount: _cubit.state.data?.certificates?.length ?? 0)),
                padding: const EdgeInsets.symmetric(horizontal: 20),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    "Bằng cấp",
                    style: GoogleFonts.montserrat(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SliverPadding(
                sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                  return CertificateDegreeItem(
                      title: "${_cubit.state.data?.degrees?[index]?.title}",
                      organization:
                          "${_cubit.state.data?.degrees?[index]?.organization}");
                }, childCount: _cubit.state.data?.degrees?.length ?? 0)),
                padding: const EdgeInsets.symmetric(horizontal: 20),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 10,
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              AvatarWidget(
                                  avatar: _cubit.state.listReview?[index].user
                                          ?.avatar ??
                                      "",
                                  size: 30),
                              Expanded(
                                  child: Text(
                                _cubit.state.listReview?[index].user?.name ??
                                    "",
                                style: GoogleFonts.montserrat(
                                    fontSize: 14, fontWeight: FontWeight.w600),
                              ))
                            ],
                          ),
                          RatingBar.builder(
                            itemSize: 20,
                            initialRating: _cubit
                                    .state.listReview?[index].rating
                                    ?.toDouble() ??
                                0,
                            minRating: 1,
                            direction: Axis.horizontal,
                            itemCount: 5,
                            itemPadding:
                                const EdgeInsets.symmetric(horizontal: 2.0),
                            itemBuilder: (context, index) => const Icon(
                              Icons.star,
                              color: Colors.yellow,
                            ),
                            onRatingUpdate: (value) {},
                          ),
                          Text(
                            _cubit.state.listReview?[index].detail ?? "",
                            style: GoogleFonts.montserrat(
                                fontSize: 14, fontWeight: FontWeight.w400),
                          )
                        ],
                      ),
                    );
                  }, childCount: _cubit.state.listReview?.length),
                ),
              )
            ],
          );
        },
      ),
    );
  }

  Future<dynamic> buildInputDay(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (BuildContext context,
                void Function(void Function()) setState) {
              return AlertDialog(
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Số ngày bạn muốn quảng cáo là: ",
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w600, fontSize: 14),
                      ),
                      TextField(
                        controller: _textEditingController,
                        decoration: InputDecoration(
                            hintStyle: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w400, fontSize: 12),
                            hintText: "Nhập số ngày"),
                        onChanged: (value) {
                          setState(() {
                            _cubit.priceAdvertisement(
                                balance: _cubit.state.data!.balance!,
                                day: int.parse(_textEditingController.text));
                          });
                        },
                      ),
                      SizedBox(height: 10),
                      if (_cubit.state.data?.balance != null &&
                          _textEditingController.text.isNotEmpty)
                        Text("Số tiền: ${Utils.formatMoney(_cubit.price)} VND",
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w600, fontSize: 14))
                    ],
                  ),
                ),
                actions: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Không",
                      style: GoogleFonts.montserrat(
                          fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      showDialog(
                          context: context,
                          builder: (contextT) {
                            return AlertDialog(
                              title: Text(
                                "Bạn đã chắc chắn số ngày quảng cáo?",
                                style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w600, fontSize: 14),
                              ),
                              actions: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(contextT);
                                  },
                                  child: Text(
                                    "Không",
                                    style: GoogleFonts.montserrat(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                SizedBox(width: 10),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(contextT);
                                    _cubit.requestDay(int.parse(
                                        _textEditingController.text.trim()));
                                  },
                                  child: Text(
                                    "Có",
                                    style: GoogleFonts.montserrat(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.red),
                                  ),
                                ),
                              ],
                            );
                          });
                    },
                    child: Text(
                      "Có",
                      style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.red),
                    ),
                  ),
                ],
              );
            },
          );
        });
  }
}
