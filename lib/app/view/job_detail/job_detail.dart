import 'package:fakeslink/app/model/request/create_my_job_request.dart';
import 'package:fakeslink/app/viewmodel/job_detail/job_detail_cubit.dart';
import 'package:fakeslink/app/viewmodel/job_detail/job_detail_state.dart';
import 'package:fakeslink/core/const/app_colors.dart';
import 'package:fakeslink/core/custom_widgets/button_widget.dart';
import 'package:fakeslink/core/custom_widgets/circle_avatar_widget.dart';
import 'package:fakeslink/core/custom_widgets/custom_appbar.dart';
import 'package:fakeslink/core/utils/utils.dart';
import 'package:fakeslink/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class JobDetailPage extends StatefulWidget {
  final int? jobId;

  const JobDetailPage({Key? key, this.jobId}) : super(key: key);

  @override
  State<JobDetailPage> createState() => _JobDetailPageState();
}

class _JobDetailPageState extends State<JobDetailPage> {
  late JobDetailCubit _cubit;
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _cubit = JobDetailCubit();
    _cubit.getJobDetail(jobDetailId: widget.jobId);
    _cubit.getOffers(id: widget.jobId);
    _cubit.getSameJob(categories: 1, offset: 0);
    _cubit.getMyOffer(offerId: widget.jobId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, "Details",
          textColor: AppColor.primaryColor,
          iconColor: AppColor.primaryColor,
          centerTitle: true,
          rightWidget: Padding(
            padding: const EdgeInsets.only(top: 18, right: 5),
            child: Text(
              "Delete",
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                  color: AppColor.red, fontWeight: FontWeight.w600),
            ),
          )),
      body: BlocConsumer<JobDetailCubit, JobDetailState>(
        bloc: _cubit,
        listener: (context, state) {
          if (state.status == JobDetailStatus.createMyJobSuccess) {
            _cubit.getMyOffer(offerId: 9);
            _cubit.getSameJob(categories: 1, offset: 0);
          }
        },
        builder: (context, state) {
          if (state.status == JobDetailStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          return CustomScrollView(
            shrinkWrap: true,
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Row(
                    children: [
                      AvatarWidget(
                        avatar: _cubit.state.jobDetail?.poster?.avatar ?? "",
                        size: 50,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _cubit.state.jobDetail?.poster?.name ?? "",
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w500, fontSize: 14),
                            ),
                            Text(
                              "Poster",
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w500, fontSize: 14),
                            )
                          ],
                        ),
                      ),
                      Text(
                        "Share",
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: AppColor.primaryColor),
                      )
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: CarouselSlider.builder(
                    unlimitedMode: true,
                    autoSliderDelay: const Duration(seconds: 2),
                    scrollDirection: Axis.horizontal,
                    enableAutoSlider: true,
                    keepPage: true,
                    slideTransform: const CubeTransform(),
                    slideIndicator: CircularSlideIndicator(
                      currentIndicatorColor: AppColor.primaryColor,
                      padding: const EdgeInsets.only(bottom: 32),
                    ),
                    slideBuilder: (int index) {
                      return Image.network(
                          _cubit.state.jobDetail?.images?[index] ?? "");
                    },
                    itemCount: _cubit.state.jobDetail?.images?.length ?? 0,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _cubit.state.jobDetail?.title ?? "",
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w600, fontSize: 16),
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        runSpacing: 10,
                        children: List.generate(
                            _cubit.state.jobDetail?.categories?.length ?? 0,
                            (index) => Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 3),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: AppColor.primaryColor
                                          .withOpacity(0.3)),
                                  child: Text(
                                    _cubit.state.jobDetail?.categories?[index]
                                            .name ??
                                        "",
                                    style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                        color: AppColor.primaryColor),
                                  ),
                                )),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Description",
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w600, fontSize: 16),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        _cubit.state.jobDetail?.description ?? "",
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w400, fontSize: 14),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "From",
                                style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w600, fontSize: 16),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                Utils.formatDateTime(
                                    _cubit.state.jobDetail?.poster?.createAt ??
                                        ""),
                                style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w500, fontSize: 16),
                              ),
                            ],
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "To",
                                  style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  Utils.formatDateTime(_cubit
                                          .state.jobDetail?.poster?.updateAt ??
                                      ""),
                                  style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Address",
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w600, fontSize: 16),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "${_cubit.state.jobDetail?.address?.detail ?? ""}, ${_cubit.state.jobDetail?.address?.ward}, ${_cubit.state.jobDetail?.address?.district}, ${_cubit.state.jobDetail?.address?.city}",
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: AppColor.primaryColor),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Budget",
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w600, fontSize: 16),
                            ),
                          ),
                          Text(
                            (Utils.formatMoney(_cubit
                                        .state.jobDetail?.payment?.amount) ??
                                    "") +
                                "đ",
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w600, fontSize: 16),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Visibility(
                        visible: _cubit.state.offers?.isNotEmpty ?? false,
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.grey.shade200),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 8),
                          child: Row(
                            children: [
                              Text(
                                "${_cubit.state.offers?.length} Offer",
                                style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    color: AppColor.primaryColor),
                              ),
                              // Expanded(
                              //   child: AvatarStack(
                              //       height: 30,
                              //       infoWidgetBuilder: textInfoWidgetBuilder,
                              //       borderColor: Colors.white,
                              //       avatars: List.generate(
                              //           _cubit.state.offers?.length ?? 0,
                              //           (index) => NetworkImage(_cubit.state
                              //                   .offers?[index].user?.avatar ??
                              //               ""))),
                              // )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      GestureDetector(
                        onTap: () {
                          if (_cubit.state.jobDetail?.poster?.id ==
                              configBox.get("user").id) {
                          } else {
                            if (_cubit.state.myOfferResponse != null) {
                              showModalBottomSheet(
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(10),
                                    ),
                                  ),
                                  context: context,
                                  builder: (context) {
                                    return SingleChildScrollView(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  "Status",
                                                  style: GoogleFonts.montserrat(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 16),
                                                ),
                                              ),
                                              Text(
                                                "YOUR OFFER",
                                                style: GoogleFonts.montserrat(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 13,
                                                    color: Colors.red),
                                              )
                                            ],
                                          ),
                                          const SizedBox(height: 10),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  "Wait for confirm",
                                                  style: GoogleFonts.montserrat(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 14,
                                                      color: Colors.green),
                                                ),
                                              ),
                                              Text((Utils.formatMoney(_cubit
                                                          .state
                                                          .myOfferResponse
                                                          ?.price) ??
                                                      "") +
                                                  "đ")
                                            ],
                                          ),
                                          const SizedBox(height: 10),
                                          Text(_cubit.state.myOfferResponse
                                                  ?.description ??
                                              ""),
                                          const SizedBox(height: 10),
                                          Row(
                                            children: [
                                              const Expanded(
                                                child: Text(
                                                    "(You can Cancel this offer and redeal)"),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  child: Text(
                                                    "Cancel",
                                                    style:
                                                        GoogleFonts.montserrat(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      color: Colors.deepOrange),
                                                  width: 100,
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    );
                                  });
                            } else {
                              buildCreateMyJob(context);
                            }
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: _cubit.state.jobDetail?.poster?.id ==
                                      configBox.get("user").id
                                  ? AppColor.primaryColor
                                  : Colors.deepOrange),
                          child: Center(
                            child: Text(
                              _cubit.state.jobDetail?.poster?.id ==
                                      configBox.get("user").id
                                  ? "View Offers"
                                  : _cubit.state.myOfferResponse == null
                                      ? "Chào giá"
                                      : "Xem chào giá",
                              style: GoogleFonts.montserrat(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Công việc tương tự",
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w600, fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
              SliverPadding(
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 5),
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.grey.shade200)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                AvatarWidget(
                                    avatar: _cubit.state.sameJobResponse
                                            ?.results?[index]?.poster?.avatar ??
                                        "",
                                    size: 40),
                                const SizedBox(width: 5),
                                Expanded(
                                  child: Text(
                                    _cubit.state.sameJobResponse
                                            ?.results?[index]?.poster?.name ??
                                        "",
                                    style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              _cubit.state.sameJobResponse?.results?[index]
                                      ?.title ??
                                  "",
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w600, fontSize: 16),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Expanded(
                                  child: Wrap(
                                    spacing: 10,
                                    runSpacing: 10,
                                    children: List.generate(
                                        _cubit
                                                .state
                                                .sameJobResponse
                                                ?.results?[index]
                                                ?.categories
                                                ?.length ??
                                            0,
                                        (currentIndex) => Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 15,
                                                      vertical: 3),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  color: AppColor.primaryColor
                                                      .withOpacity(0.3)),
                                              child: Text(
                                                _cubit
                                                        .state
                                                        .sameJobResponse
                                                        ?.results?[index]
                                                        ?.categories?[
                                                            currentIndex]
                                                        .name ??
                                                    "",
                                                style: GoogleFonts.montserrat(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 14,
                                                    color:
                                                        AppColor.primaryColor),
                                              ),
                                            )),
                                  ),
                                ),
                                Text(
                                  Utils.formatMoney(
                                          "${_cubit.state.sameJobResponse?.results?[index]?.payment?.amount}") ??
                                      "",
                                  style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Icon(
                                            Icons.lock_clock,
                                            color: AppColor.primaryColor,
                                          ),
                                          const SizedBox(width: 5),
                                          Expanded(
                                            child: Text(
                                              DateFormat("hh:mm").format(
                                                  DateTime.parse(_cubit
                                                          .state
                                                          .sameJobResponse
                                                          ?.results?[index]
                                                          ?.poster
                                                          ?.updateAt ??
                                                      "")),
                                              style: GoogleFonts.montserrat(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14),
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(height: 5),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.calendar_month,
                                            color: AppColor.primaryColor,
                                          ),
                                          const SizedBox(width: 5),
                                          Expanded(
                                              child: Text(
                                                  Utils.formatDateTime(_cubit
                                                          .state
                                                          .sameJobResponse
                                                          ?.results?[index]
                                                          ?.poster
                                                          ?.updateAt ??
                                                      ""),
                                                  style: GoogleFonts.montserrat(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 14)))
                                        ],
                                      ),
                                      const SizedBox(height: 5),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.location_on_rounded,
                                            color: AppColor.primaryColor,
                                          ),
                                          const SizedBox(width: 5),
                                          Expanded(
                                              child: Text(
                                                  "${_cubit.state.sameJobResponse?.results?[index]?.address?.district}, ${_cubit.state.sameJobResponse?.results?[index]?.address?.city}",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  style: GoogleFonts.montserrat(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 14)))
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Text(
                                  _cubit.state.sameJobResponse?.results?[index]
                                              ?.status ==
                                          "Opening"
                                      ? "Đang chờ"
                                      : "Đã hoàn thành",
                                  style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                      color: Colors.green),
                                )
                              ],
                            ),
                            const SizedBox(height: 8),
                          ],
                        ),
                      );
                    },
                    childCount: _cubit.state.sameJobResponse?.results?.length ??
                        0, // 1000 list items
                  ),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<dynamic> buildCreateMyJob(BuildContext context) {
    return showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(10),
          ),
        ),
        context: context,
        builder: (context) {
          return SingleChildScrollView(
            padding: MediaQuery.of(context).viewInsets,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Column(
                children: [
                  TextField(
                    controller: _priceController,
                    maxLines: 1,
                    decoration: InputDecoration(hintText: "Nhập giá tiền"),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: _descriptionController,
                    maxLines: 1,
                    decoration: InputDecoration(hintText: "Nhập mô tả"),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                          child: ButtonWidget(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 5),
                              title: "Hủy",
                              backgroundColor: Colors.white,
                              borderColor: Colors.grey.shade300,
                              textColor: Colors.deepOrange,
                              onPressed: () {
                                Navigator.pop(context);
                              })),
                      SizedBox(width: 15),
                      Expanded(
                          child: ButtonWidget(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 5),
                              backgroundColor: Colors.deepOrange,
                              textColor: Colors.white,
                              title: "OK",
                              onPressed: () {
                                Navigator.pop(context);
                                _cubit.createMyJob(
                                    price: _priceController.text.trim(),
                                    description:
                                        _descriptionController.text.trim(),
                                    jobId: widget.jobId);
                              })),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  Widget textInfoWidgetBuilder(surplus) => Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            gradient: const LinearGradient(
                colors: [
                  Colors.teal,
                  Colors.teal,
                  Colors.white,
                  Colors.white
                  //add more colors for gradient
                ],
                begin: Alignment.centerLeft, //begin of the gradient color
                end: Alignment.centerRight, //end of the gradient color
                stops: [0, 0.2, 0.7, 0.8] //stops for individual color
                //set the stops number equal to numbers of color
                ),
            borderRadius: BorderRadius.circular(50),
            border: Border.all(color: Colors.white)),
        child: Text('+$surplus',
            style:
                Theme.of(context).textTheme.headline6?.copyWith(fontSize: 12)),
      );
}
