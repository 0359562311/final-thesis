import 'package:fakeslink/app/model/request/create_my_job_request.dart';
import 'package:fakeslink/app/viewmodel/job_detail/job_detail_cubit.dart';
import 'package:fakeslink/app/viewmodel/job_detail/job_detail_state.dart';
import 'package:fakeslink/core/const/app_colors.dart';
import 'package:fakeslink/core/custom_widgets/button_widget.dart';
import 'package:fakeslink/core/custom_widgets/circle_avatar_widget.dart';
import 'package:fakeslink/core/custom_widgets/custom_appbar.dart';
import 'package:fakeslink/core/custom_widgets/job_item.dart';
import 'package:fakeslink/core/utils/extensions/string.dart';
import 'package:fakeslink/core/utils/utils.dart';
import 'package:fakeslink/main.dart';
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
  late JobDetailViewModel _viewmodel;
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _viewmodel = JobDetailViewModel();
    _viewmodel.getJobDetail(jobDetailId: widget.jobId);
    _viewmodel.getOffers(id: widget.jobId);
    _viewmodel.getSameJob(categories: 1, offset: 0);
    _viewmodel.getMyOffer(jobId: widget.jobId);
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
      body: BlocConsumer<JobDetailViewModel, JobDetailState>(
        bloc: _viewmodel,
        listener: (context, state) {
          if (state.status == JobDetailStatus.createOfferSuccess) {
            _viewmodel.getMyOffer(jobId: widget.jobId);
            _viewmodel.getSameJob(
                categories: state.jobDetail?.categories?.first.id, offset: 0);
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
                        avatar:
                            _viewmodel.state.jobDetail?.poster?.avatar ?? "",
                        size: 50,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          _viewmodel.state.jobDetail?.poster?.name ?? "",
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w500, fontSize: 14),
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
              if (_viewmodel.state.jobDetail?.images?.isEmpty == true)
                SliverToBoxAdapter(
                  child: Container(
                    child: Text("Không có hình ảnh minh hoạ"),
                    width: double.infinity,
                    height: MediaQuery.of(context).size.width / 16 * 9,
                    alignment: Alignment.center,
                  ),
                ),
              if (_viewmodel.state.jobDetail?.images?.isNotEmpty == true)
                SliverToBoxAdapter(
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: CarouselSlider.builder(
                      unlimitedMode: true,
                      autoSliderDelay: const Duration(seconds: 2),
                      scrollDirection: Axis.horizontal,
                      enableAutoSlider: true,
                      keepPage: true,
                      slideIndicator: CircularSlideIndicator(
                        currentIndicatorColor: AppColor.primaryColor,
                        padding: const EdgeInsets.only(bottom: 32),
                      ),
                      slideBuilder: (int index) {
                        return Image.network(
                            _viewmodel.state.jobDetail?.images?[index] ?? "");
                      },
                      itemCount:
                          _viewmodel.state.jobDetail?.images?.length ?? 0,
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
                        _viewmodel.state.jobDetail?.title ?? "",
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w600, fontSize: 16),
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        runSpacing: 10,
                        spacing: 10,
                        children: List.generate(
                            _viewmodel.state.jobDetail?.categories?.length ?? 0,
                            (index) => Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 3),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: AppColor.primaryColor
                                          .withOpacity(0.3)),
                                  child: Text(
                                    _viewmodel.state.jobDetail
                                            ?.categories?[index].name ??
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
                        "Mô tả",
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w600, fontSize: 16),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        _viewmodel.state.jobDetail?.description ?? "",
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w400, fontSize: 14),
                      ),
                      const SizedBox(height: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Ngày hết hạn",
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w600, fontSize: 16),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            df.format(_viewmodel.state.jobDetail?.dueDate ??
                                DateTime.now()),
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w500, fontSize: 16),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      if (_viewmodel.state.jobDetail?.address != null) ...[
                        Text(
                          "Địa chỉ",
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w600, fontSize: 16),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "${_viewmodel.state.jobDetail?.address?.detail ?? ""}, ${_viewmodel.state.jobDetail?.address?.ward}, ${_viewmodel.state.jobDetail?.address?.district}, ${_viewmodel.state.jobDetail?.address?.city}",
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: AppColor.primaryColor),
                        ),
                      ],
                      if (_viewmodel.state.jobDetail?.address == null)
                        Text(
                          "Công việc từ xa",
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: AppColor.primaryColor),
                        ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Kinh phí",
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w600, fontSize: 16),
                            ),
                          ),
                          Text(
                            (Utils.formatMoney(_viewmodel
                                        .state.jobDetail?.payment?.amount) ??
                                    "") +
                                " VND",
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w600, fontSize: 16),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Visibility(
                        visible: _viewmodel.state.offers?.isNotEmpty ?? false,
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
                                "${_viewmodel.state.offers?.length} chào giá",
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
                          if (_viewmodel.state.jobDetail?.poster?.id ==
                              configBox.get("user").id) {
                          } else {
                            if (_viewmodel.state.myOffer != null) {
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
                                              Text((Utils.formatMoney(_viewmodel
                                                          .state
                                                          .myOffer
                                                          ?.price) ??
                                                      "") +
                                                  "đ")
                                            ],
                                          ),
                                          const SizedBox(height: 10),
                                          Text(_viewmodel
                                                  .state.myOffer?.description ??
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
                              color: _viewmodel.state.jobDetail?.poster?.id ==
                                      configBox.get("user").id
                                  ? AppColor.primaryColor
                                  : Colors.deepOrange),
                          child: Center(
                            child: Text(
                              _viewmodel.state.jobDetail?.poster?.id ==
                                      configBox.get("user").id
                                  ? "View Offers"
                                  : _viewmodel.state.myOffer == null
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
                      return JobItem(data: _viewmodel.state.sameJobs![index]);
                    },
                    childCount: _viewmodel.state.sameJobs?.length ??
                        0, // 1000 list items
                  ),
                ),
                padding: const EdgeInsets.symmetric(vertical: 10),
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
                                _viewmodel.createMyJob(
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
