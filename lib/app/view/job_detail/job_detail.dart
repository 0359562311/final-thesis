import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:fakeslink/app/model/entities/job.dart';
import 'package:fakeslink/app/view/all_offers/all_offers.dart';
import 'package:fakeslink/app/view/profile/profile.dart';
import 'package:fakeslink/app/view/verify_password/verify_password.dart';
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
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:flutter_carousel_slider/carousel_slider_indicators.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class JobDetailPage extends StatefulWidget {
  final int? jobId;
  final int? categoryId;

  const JobDetailPage({Key? key, this.jobId, this.categoryId})
      : super(key: key);

  @override
  State<JobDetailPage> createState() => _JobDetailPageState();
}

class _JobDetailPageState extends State<JobDetailPage> {
  late JobDetailViewModel _viewmodel;
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _inputDayController = TextEditingController();
  String? selectedValue;
  final List<String> items = [
    'Đóng',
    'Đẩy tìm kiếm công việc',
    'Xem người tìm việc phù hợp',
  ];

  @override
  void initState() {
    super.initState();
    _viewmodel = JobDetailViewModel();
    _viewmodel.getJobDetail(jobDetailId: widget.jobId);
    _viewmodel.getOffers(jobId: widget.jobId);
    _viewmodel.getSameJob(categories: widget.categoryId, offset: 0);
    _viewmodel.getMyOffer(jobId: widget.jobId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<JobDetailViewModel, JobDetailState>(
        bloc: _viewmodel,
        listener: (context, state) {
          if (state.status == JobDetailStatus.createOfferSuccess ||
              state.status == JobDetailStatus.updateDaySuccess) {
            _viewmodel.getMyOffer(jobId: widget.jobId);
            _viewmodel.getSameJob(
                categories: state.jobDetail?.categories?.first.id, offset: 0);
            _viewmodel.getJobDetail(jobDetailId: widget.jobId);
          }
          if (state.status == JobDetailStatus.closedOfferSuccess) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          if (state.status == JobDetailStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          return Scaffold(
            appBar: appBar(
              context,
              "Chi tiết công việc",
              textColor: AppColor.primaryColor,
              iconColor: AppColor.primaryColor,
              centerTitle: true,
              rightWidget: Visibility(
                visible: _viewmodel.state.jobDetail?.poster?.id ==
                    configBox.get("user").id,
                child: DropdownButtonHideUnderline(
                  child: DropdownButton2(
                    hint: Text(
                      'Select Item',
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).hintColor,
                      ),
                    ),
                    items: items
                        .map((item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: AppColor.primaryColor),
                              ),
                            ))
                        .toList(),
                    value: selectedValue,
                    onChanged: (String? value) async {
                      setState(() {
                        selectedValue = value;
                      });
                      if (value == "Đóng") {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text(
                                  'Bạn có muộn đóng công việc không?',
                                  style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16),
                                ),
                                actions: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      "Không",
                                      style: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                      _viewmodel.updateJobStatus(
                                          widget.jobId ?? 0, JobStatus.Closed);
                                    },
                                    child: Text(
                                      "Có",
                                      style: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                          color: Colors.red),
                                    ),
                                  )
                                ],
                              );
                            });
                      } else if (value == "Đẩy tìm kiếm công việc") {
                        final res = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const VerifyPasswordPage()));
                        if (res == true) {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return StatefulBuilder(
                                  builder: (BuildContext context,
                                      void Function(void Function()) setState) {
                                    return AlertDialog(
                                      content: SingleChildScrollView(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Nhập số ngày",
                                              style: GoogleFonts.montserrat(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 16),
                                            ),
                                            TextField(
                                              controller: _inputDayController,
                                              maxLines: 1,
                                              decoration: const InputDecoration(
                                                hintText: "Nhập số ngày",
                                              ),
                                              keyboardType:
                                                  TextInputType.number,
                                              onChanged: (value) {
                                                setState(() {
                                                  _viewmodel.priceAdvertisement(
                                                      balance: _viewmodel
                                                          .state
                                                          .jobDetail!
                                                          .payment!
                                                          .amount!,
                                                      day: int.parse(
                                                          _inputDayController
                                                              .text));
                                                });
                                              },
                                            ),
                                            const SizedBox(height: 10),
                                            if (_viewmodel.state.jobDetail
                                                        ?.payment?.amount !=
                                                    null &&
                                                _inputDayController
                                                    .text.isNotEmpty)
                                              Text(
                                                  "Số tiền: ${Utils.formatMoney(_viewmodel.price)} VND")
                                          ],
                                        ),
                                      ),
                                      actions: [
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text("Không",
                                              style: GoogleFonts.montserrat(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14)),
                                        ),
                                        const SizedBox(width: 10),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.pop(context);
                                            _viewmodel.createDay(
                                                jobId: _viewmodel
                                                    .state.jobDetail?.id,
                                                day: int.parse(
                                                    _inputDayController.text));
                                          },
                                          child: Text("Có",
                                              style: GoogleFonts.montserrat(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14,
                                                  color: Colors.red)),
                                        ),
                                        const SizedBox(width: 10),
                                      ],
                                    );
                                  },
                                );
                              });
                        }
                      }
                    },
                    buttonHeight: 40,
                    itemHeight: 40,
                  ),
                ),
              ),
            ),
            body: CustomScrollView(
              shrinkWrap: true,
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UserProfilePage(
                                          userId: _viewmodel.state.jobDetail
                                                  ?.poster?.id ??
                                              0,
                                        )));
                          },
                          child: AvatarWidget(
                            avatar:
                                _viewmodel.state.jobDetail?.poster?.avatar ??
                                    "",
                            size: 50,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            _viewmodel.state.jobDetail?.poster?.name ?? "",
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w500, fontSize: 14),
                          ),
                        ),
                        Visibility(
                          visible: _viewmodel.state.jobDetail?.status ==
                                  JobStatus.Closed.name &&
                              (_viewmodel.state.jobDetail?.poster?.id ==
                                  configBox.get("user").id),
                          child: Text(
                            "Đã đóng",
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                color: AppColor.red),
                          ),
                        ),
                        Visibility(
                          visible: _viewmodel.state.jobDetail?.status ==
                                  JobStatus.Pending.name &&
                              (_viewmodel.state.jobDetail?.poster?.id ==
                                  configBox.get("user").id),
                          child: Text(
                            "Đang chờ hoàn thành",
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                color: AppColor.primaryColor),
                          ),
                        ),
                        Visibility(
                          visible: _viewmodel.state.jobDetail?.status ==
                                  JobStatus.Opening.name &&
                              (_viewmodel.state.jobDetail?.poster?.id ==
                                  configBox.get("user").id),
                          child: Text(
                            "Đang chờ nhận việc",
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                color: AppColor.secondaryColor),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                if (_viewmodel.state.jobDetail?.images?.isEmpty == true)
                  SliverToBoxAdapter(
                    child: Container(
                      child: const Text("Không có hình ảnh minh hoạ"),
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
                if (_viewmodel.dueDate != null)
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 5),
                      child: Text(
                        "Công việc được đẩy quảng cáo tới ngày ${DateFormat("dd/MM/yyy").format(DateTime.parse(_viewmodel.dueDate ?? ""))}",
                        maxLines: 2,
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w600, fontSize: 16),
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
                              _viewmodel.state.jobDetail?.categories?.length ??
                                  0,
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
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AllOfferPage(
                                            jobId: widget.jobId,
                                          ))).then((value) {
                                _viewmodel.getJobDetail(
                                    jobDetailId: widget.jobId);
                                _viewmodel.getSameJob(
                                    categories: widget.categoryId, offset: 0);
                                _viewmodel.getOffers(jobId: widget.jobId);
                              });
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
                                            const SizedBox(height: 10),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    "Đang chờ duyệt",
                                                    style:
                                                        GoogleFonts.montserrat(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 14,
                                                            color:
                                                                Colors.green),
                                                  ),
                                                ),
                                                Text((Utils.formatMoney(
                                                            _viewmodel
                                                                .state
                                                                .myOffer
                                                                ?.price) ??
                                                        "") +
                                                    " VND")
                                              ],
                                            ),
                                            const SizedBox(height: 10),
                                            Text(_viewmodel.state.myOffer
                                                    ?.description ??
                                                ""),
                                            const SizedBox(height: 10),
                                            Row(
                                              children: [
                                                const Expanded(
                                                  child: Text(
                                                      "(Bạn có thể huỷ chào giá này và tạo mới)"),
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                    _viewmodel.closedOffer(
                                                        widget.jobId!);
                                                  },
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    child: Text(
                                                      "Huỷ",
                                                      style: GoogleFonts
                                                          .montserrat(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                        color:
                                                            Colors.deepOrange),
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
                                    ? "Xem chào giá"
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
            ),
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
                    decoration:
                        const InputDecoration(hintText: "Nhập giá tiền"),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _descriptionController,
                    maxLines: 1,
                    decoration: const InputDecoration(hintText: "Nhập mô tả"),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                          child: ButtonWidget(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 5),
                              title: "Hủy",
                              backgroundColor: Colors.white,
                              borderColor: Colors.grey.shade300,
                              textColor: Colors.deepOrange,
                              onPressed: () {
                                Navigator.pop(context);
                              })),
                      const SizedBox(width: 15),
                      Expanded(
                          child: ButtonWidget(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 5),
                              backgroundColor: Colors.deepOrange,
                              textColor: Colors.white,
                              title: "OK",
                              onPressed: () {
                                Navigator.pop(context);
                                _viewmodel.createMyOffer(
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

  bool checkDay() {
    if (_inputDayController.text.isNotEmpty &&
        DateTime.now().difference(_viewmodel.state.jobDetail!.dueDate!).inDays >
            Duration(days: int.parse(_inputDayController.text)).inDays) {
      return true;
    }
    return false;
  }
}
