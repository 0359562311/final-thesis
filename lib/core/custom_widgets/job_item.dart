import 'package:fakeslink/app/model/entities/job.dart';
import 'package:fakeslink/core/const/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'circle_avatar_widget.dart';

class JobItem extends StatelessWidget {
  final Job data;
  const JobItem({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: Row(
              children: [
                AvatarWidget(avatar: data.poster?.avatar, size: 24),
                SizedBox(
                  width: 8,
                ),
                Text(
                  data.poster?.name ?? "",
                  style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.bold, fontSize: 14),
                )
              ],
            ),
          ),
          Divider(
            height: 1,
            color: AppColor.black,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: Text(
              data.title ?? "",
              style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.bold, fontSize: 14),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Wrap(
              spacing: 10,
              children: (data.categories ?? [])
                  .map((e) => Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: AppColor.primaryColor.withOpacity(0.3)),
                        child: Text(
                          e.name ?? "",
                          style: GoogleFonts.montserrat(
                              fontSize: 12, color: AppColor.primaryColor),
                        ),
                      ))
                  .toList(),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Icon(
                  Icons.attach_money,
                  color: AppColor.primaryColor,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "${data.payment?.amount} VND",
                  style: GoogleFonts.montserrat(fontSize: 14),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Icon(
                  Icons.calendar_month,
                  color: AppColor.primaryColor,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "còn ${(data.dueDate ?? DateTime.now().add(Duration(days: 14))).difference(DateTime.now()).inDays} ngày",
                  style: GoogleFonts.montserrat(fontSize: 14),
                ),
                Spacer(),
                Icon(
                  CupertinoIcons.bag_fill,
                  color: AppColor.primaryColor,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "Đang mở",
                  style: GoogleFonts.montserrat(
                      fontSize: 14, color: Colors.lightGreen),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Icon(
                  CupertinoIcons.location_solid,
                  color: AppColor.primaryColor,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  data.address != null
                      ? data.address!.toString()
                      : "Việc làm từ xa",
                  style: GoogleFonts.montserrat(fontSize: 14),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}