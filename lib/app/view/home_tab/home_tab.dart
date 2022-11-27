import 'package:fakeslink/core/const/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                Text("Hi, Tan!"),
                Spacer(),
                CircleAvatar(
                  backgroundImage: NetworkImage(
                    "https://images.viblo.asia/avatar/3d9d5f45-1245-4674-aefd-de59ada3685e.jpg",
                  ),
                )
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text(
                "Best Jobs",
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
                scrollDirection: Axis.horizontal,
                itemCount: 13,
                itemBuilder: (context, index) {
                  return Center(
                    child: Padding(
                        padding: EdgeInsets.only(right: 10, left: 6),
                        child: Text(
                          "Category $index",
                          style: GoogleFonts.montserrat(
                              color: index == 3 ? AppColor.primaryColor : null,
                              decoration:
                                  index == 3 ? TextDecoration.underline : null),
                        )),
                  );
                }),
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 90,
            child: ListView.builder(
              itemCount: 3,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
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
                            "Title",
                            style: GoogleFonts.montserrat(
                                color: AppColor.primaryColor,
                                fontWeight: FontWeight.bold),
                          ),
                          Text("30.000 VND"),
                          Text("Ha dong Ha noi")
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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: Text(
              "Post",
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
                color: AppColor.white, borderRadius: BorderRadius.circular(10)),
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
                      borderRadius: BorderRadius.circular(10)
                    ),
                  );
                }),
          ),
        )
      ],
    );
  }
}
