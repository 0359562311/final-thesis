import 'package:fakeslink/app/view/job_detail/job_detail.dart';
import 'package:fakeslink/app/viewmodel/home/activities_tab/offer_history/offer_history_cubit.dart';
import 'package:fakeslink/app/viewmodel/home/activities_tab/offer_history/offer_history_state.dart';
import 'package:fakeslink/core/const/app_colors.dart';
import 'package:fakeslink/core/custom_widgets/circle_avatar_widget.dart';
import 'package:fakeslink/core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class OfferHistoryPage extends StatefulWidget {
  const OfferHistoryPage({Key? key}) : super(key: key);

  @override
  State<OfferHistoryPage> createState() => _OfferHistoryPageState();
}

class _OfferHistoryPageState extends State<OfferHistoryPage> {
  late OfferHistoryCubit _cubit;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _cubit = OfferHistoryCubit();
    _cubit.getOfferHistory();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OfferHistoryCubit, OfferHistoryState>(
      bloc: _cubit,
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, state) {
        if (state.status == OfferHistoryStatus.loading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView.builder(
            itemCount: _cubit.state.offerHistory?.length,
            itemBuilder: (context, int index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => JobDetailPage(
                                jobId:
                                    _cubit.state.offerHistory?[index].job?.id ??
                                        0,
                                categoryId: 2,
                              )));
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  margin:
                      EdgeInsets.only(left: 16, right: 16, bottom: 5, top: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.grey)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          AvatarWidget(
                              avatar: _cubit.state.offerHistory?[index].user
                                      ?.avatar ??
                                  "",
                              size: 40),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              _cubit.state.offerHistory?[index].user?.name ??
                                  "",
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w500, fontSize: 14),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              _cubit.state.offerHistory?[index].job?.title ??
                                  "",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w500, fontSize: 14),
                            ),
                          ),
                          Text(
                            _statusJob(
                                    _cubit.state.offerHistory?[index].status ??
                                        "") ??
                                "",
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: AppColor.primaryColor),
                          )
                        ],
                      ),
                      SizedBox(height: 5),
                      Text(
                        (Utils.formatMoney(_cubit.state.offerHistory?[index].job
                                    ?.payment?.amount) ??
                                "") +
                            " VND",
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: AppColor.primaryColor),
                      ),
                      SizedBox(height: 5),
                      Divider(),
                      Text(
                        "Offer của tôi",
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w600, fontSize: 14),
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              (Utils.formatMoney(_cubit
                                          .state.offerHistory?[index].price) ??
                                      "") +
                                  " VND",
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: AppColor.primaryColor),
                            ),
                          ),
                          Text(
                            _statusOffer(_cubit.state.offerHistory?[index].job
                                        ?.status ??
                                    "") ??
                                "",
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: AppColor.primaryColor),
                          )
                        ],
                      ),
                      SizedBox(height: 5),
                      Text(
                        _cubit.state.offerHistory?[index].description ?? "",
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w500, fontSize: 14),
                      ),
                    ],
                  ),
                ),
              );
            });
      },
    );
  }

  String? _statusOffer(String statusOffer) {
    String? status;
    if (statusOffer == "Opening") {
      status = "Đang mở";
    } else if (statusOffer == "Closed") {
      status = "Đã đóng";
    } else if (statusOffer == "Pending") {
      status = "Đang chờ duyệt";
    }
    return status;
  }

  String? _statusJob(String statusJob) {
    String? status;
    if (statusJob == "Approves") {
      status = "Đang mở";
    } else if (statusJob == "Closed") {
      status = "Đã đóng";
    } else if (statusJob == "Pending") {
      status = "Đang chờ duyệt";
    }
    return status;
  }
}
