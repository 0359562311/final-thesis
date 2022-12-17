import 'package:fakeslink/app/viewmodel/all_offers/all_offers_cubit.dart';
import 'package:fakeslink/app/viewmodel/all_offers/all_offers_state.dart';
import 'package:fakeslink/core/const/app_colors.dart';
import 'package:fakeslink/core/custom_widgets/button_widget.dart';
import 'package:fakeslink/core/custom_widgets/circle_avatar_widget.dart';
import 'package:fakeslink/core/custom_widgets/custom_appbar.dart';
import 'package:fakeslink/core/utils/extensions/string.dart';
import 'package:fakeslink/core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

enum Status { Approved, Pending }

class AllOfferPage extends StatefulWidget {
  final int? jobId;

  const AllOfferPage({Key? key, this.jobId}) : super(key: key);

  @override
  State<AllOfferPage> createState() => _AllOfferPageState();
}

class _AllOfferPageState extends State<AllOfferPage> {
  late AllOffersCubit _cubit;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _cubit = AllOffersCubit();
    _cubit.getAllOffer(jobId: widget.jobId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: appBar(context, "All Offers",
          textColor: AppColor.primaryColor,
          elevation: 1,
          centerTitle: true,
          iconColor: AppColor.primaryColor),
      body: BlocConsumer<AllOffersCubit, AllOffersState>(
        bloc: _cubit,
        listener: (context, state) {
          if (state.status == AllOfferStatus.acceptSuccess) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          if (state.status == AllOfferStatus.loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return CustomScrollView(
            shrinkWrap: true,
            slivers: [
              SliverToBoxAdapter(
                child: SizedBox(height: 10),
              ),
              if (_cubit.state.offers?.isEmpty ?? false)
                SliverToBoxAdapter(
                  child: Center(
                      heightFactor: 20,
                      child: Text(
                        "Không có chào giá nào!",
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: AppColor.primaryColor),
                      )),
                ),
              if (_cubit.state.offers?.isNotEmpty ?? false)
                SliverPadding(
                  sliver: SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                    final data = _cubit.state.offers?[index];
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      margin: const EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              AvatarWidget(
                                  avatar: data?.user?.avatar ?? "", size: 40),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      data?.user?.name ?? "",
                                      style: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14),
                                    ),
                                    SizedBox(height: 5),
                                    RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                              style: GoogleFonts.montserrat(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14,
                                                  color: Colors.black),
                                              text: data?.user?.loyaltyPoint
                                                  .toString()),
                                          const WidgetSpan(
                                              child: Icon(
                                            Icons.star,
                                            size: 14,
                                            color: Colors.red,
                                          ))
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "Offer",
                                    style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    (Utils.formatMoney(data?.price) ?? "") +
                                        " VND",
                                    style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14),
                                  )
                                ],
                              )
                            ],
                          ),
                          const SizedBox(height: 5),
                          Text(
                            data?.description ?? "",
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w500, fontSize: 14),
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              if (data?.user?.createAt != null)
                                Expanded(
                                  child: Text(
                                    data?.user?.updateAt?.date ?? "",
                                    style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12),
                                  ),
                                ),
                              SizedBox(
                                width: 70,
                                child: ButtonWidget(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 3),
                                    title: "Chat",
                                    onPressed: () {},
                                    uppercaseTitle: false,
                                    textSize: 14),
                              ),
                              const SizedBox(width: 5),
                              Visibility(
                                visible: data?.status == Status.Pending.name,
                                child: Container(
                                  constraints: BoxConstraints(
                                      minWidth: 70, maxWidth: 100),
                                  child: ButtonWidget(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 3),
                                      title: "Chấp nhận",
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                title: Text(
                                                  'Trạng thái công việc',
                                                  style: GoogleFonts.montserrat(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 16),
                                                ),
                                                content: SingleChildScrollView(
                                                  child: ListBody(
                                                    children: <Widget>[
                                                      Text(
                                                        'Bạn có muốn chuyển trạng thái công việc để tạm  thời không nhận các chào giá nữa không?',
                                                        style: GoogleFonts
                                                            .montserrat(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 14),
                                                      ),
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
                                                      style: GoogleFonts
                                                          .montserrat(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 14),
                                                    ),
                                                  ),
                                                  SizedBox(width: 10),
                                                  GestureDetector(
                                                    onTap: () {
                                                      Navigator.pop(context);
                                                      _cubit.accept(
                                                          offerId: data!.id!,
                                                          jobId: widget.jobId!);
                                                    },
                                                    child: Text(
                                                      "Có",
                                                      style: GoogleFonts
                                                          .montserrat(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 14,
                                                              color:
                                                                  Colors.red),
                                                    ),
                                                  )
                                                ],
                                              );
                                            });
                                      },
                                      textSize: 14,
                                      uppercaseTitle: false),
                                ),
                              ),
                              const SizedBox(width: 5),
                              Visibility(
                                visible: data?.status == Status.Approved.name,
                                child: SizedBox(
                                  width: 70,
                                  child: ButtonWidget(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 3),
                                      title: "Pay",
                                      onPressed: () {},
                                      textSize: 14,
                                      uppercaseTitle: false),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  }, childCount: _cubit.state.offers?.length)),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                )
            ],
          );
        },
      ),
    );
  }
}
