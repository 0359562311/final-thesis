import 'package:fakeslink/app/view/profile/certificate_degree_item.dart';
import 'package:fakeslink/core/const/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UserProfilePage extends StatefulWidget {
  final int userId;
  const UserProfilePage({Key? key, required this.userId}) : super(key: key);

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: Theme.of(context).iconTheme.copyWith(color: Colors.black),
      ),
      backgroundColor: Colors.white,
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16),
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(
                "https://znews-photo.zingcdn.me/w660/Uploaded/kbd_pilk/2022_08_30/lisa67.jpg"),
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Nguyễn Kiêm Tân",
                style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.bold, fontSize: 18),
              ),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.edit,
                    size: 16,
                    color: AppColor.secondaryColor,
                  ))
            ],
          ),
          SizedBox(
            height: 16,
          ),
          Text(
            "Giới thiệu",
            style: GoogleFonts.montserrat(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            "this is an introduction\nhehe",
            style: GoogleFonts.montserrat(fontSize: 13),
          ),
          SizedBox(
            height: 16,
          ),
          Text(
            "Số điện thoại",
            style: GoogleFonts.montserrat(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            "0359562345",
            style: GoogleFonts.montserrat(
                fontSize: 13, color: AppColor.secondaryColor),
          ),
          SizedBox(
            height: 16,
          ),
          Text(
            "Email",
            style: GoogleFonts.montserrat(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            "tannk.B18CN526@stu.ptit.com",
            style: GoogleFonts.montserrat(
                fontSize: 13, color: AppColor.secondaryColor),
          ),
          SizedBox(
            height: 16,
          ),
          Text(
            "Bằng cấp",
            style: GoogleFonts.montserrat(fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: CertificateDegreeItem(
                image:
                    "https://znews-photo.zingcdn.me/w660/Uploaded/kbd_pilk/2022_08_30/lisa67.jpg",
                title: "TOEIC 840/990",
                description: "7/2022 - 10/2023",
                organization: "IIG"),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: CertificateDegreeItem(
                image:
                    "https://znews-photo.zingcdn.me/w660/Uploaded/kbd_pilk/2022_08_30/lisa67.jpg",
                title: "CCNA",
                description: "7/2022 - 10/2023",
                organization: "IIG"),
          )
        ],
      ),
    );
  }
}
