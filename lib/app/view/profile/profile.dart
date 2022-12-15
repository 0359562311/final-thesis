import 'package:fakeslink/app/view/profile/certificate_degree_item.dart';
import 'package:fakeslink/app/viewmodel/profile/view_profile/view_profile_state.dart';
import 'package:fakeslink/app/viewmodel/profile/view_profile/view_profile_viewmodel.dart';
import 'package:fakeslink/core/const/app_colors.dart';
import 'package:fakeslink/core/custom_widgets/circle_avatar_widget.dart';
import 'package:fakeslink/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class UserProfilePage extends StatefulWidget {
  final int userId;

  const UserProfilePage({Key? key, required this.userId}) : super(key: key);

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  late ViewProfileViewModel _cubit;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _cubit = ViewProfileViewModel();
    _cubit.getProfile();
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
          // TODO: implement listener
        },
        builder: (context, state) {
          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
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
              )
            ],
          );
        },
      ),
    );
  }
}
