import 'package:fakeslink/core/const/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CertificateDegreeItem extends StatelessWidget {
  final String image;
  final String title;
  final String organization;
  final String description;

  const CertificateDegreeItem(
      {Key? key,
      required this.image,
      required this.title,
      required this.description,
      required this.organization})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColor.background, borderRadius: BorderRadius.circular(8)),
      padding: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.network(
                image,
                height: 40,
                width: 40,
              ),
              SizedBox(
                width: 8,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.montserrat(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(description),
                  SizedBox(height: 4),
                  Text("tại " + organization)
                ],
              )
            ],
          ),
          // SizedBox(
          //   height: 8,
          // ),
          // Text(description)
        ],
      ),
    );
  }
}
