import 'package:fakeslink/app/view/profile/certificate_degree_item.dart';
import 'package:fakeslink/app/viewmodel/profile/view_profile/view_profile_cubit.dart';
import 'package:fakeslink/app/viewmodel/profile/view_profile/view_profile_state.dart';
import 'package:fakeslink/core/const/app_colors.dart';
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
  late ViewProfileCubit _cubit;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _cubit = ViewProfileCubit();
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
      body: BlocConsumer<ViewProfileCubit, ViewProfileState>(
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
                    const CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(
                          "https://znews-photo.zingcdn.me/w660/Uploaded/kbd_pilk/2022_08_30/lisa67.jpg"),
                    ),
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
                        "this is an introduction\nhehe",
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
                        _cubit.state.data?.phoneNumber ?? "",
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
                        "Bằng cấp",
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
                      image:
                          "https://znews-photo.zingcdn.me/w660/Uploaded/kbd_pilk/2022_08_30/lisa67.jpg",
                      title:
                          "${_cubit.state.data?.certificates?[index]?.title} ${_cubit.state.data?.certificates?[index]?.description ?? ""}",
                      description:
                          "${_cubit.state.data?.certificates?[index]?.From} - ${_cubit.state.data?.certificates?[index]?.to} ",
                      organization: "IIG");
                }, childCount: _cubit.state.data?.certificates?.length ?? 0)),
                padding: const EdgeInsets.symmetric(horizontal: 20),
              )
            ],
          );
        },
      ),
    );
  }
}
