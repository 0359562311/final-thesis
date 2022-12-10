import 'package:fakeslink/app/viewmodel/home/jobs_list/jobs_list_cubit.dart';
import 'package:fakeslink/app/viewmodel/home/jobs_list/jobs_list_state.dart';
import 'package:fakeslink/core/const/app_colors.dart';
import 'package:fakeslink/core/custom_widgets/circle_avatar_widget.dart';
import 'package:fakeslink/core/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class JobsListPage extends StatefulWidget {
  const JobsListPage({Key? key}) : super(key: key);

  @override
  State<JobsListPage> createState() => _JobsListPageState();
}

class _JobsListPageState extends State<JobsListPage>
    with AutomaticKeepAliveClientMixin<JobsListPage> {
  late final JobsListViewModel _viewModel;
  late final RefreshController _refreshController;

  @override
  void initState() {
    super.initState();
    _viewModel = JobsListViewModel();
    _viewModel.getJobs(true);
    _refreshController = RefreshController();
  }

  @override
  void dispose() {
    _viewModel.close();
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.primaryColor,
          title: CupertinoSearchTextField(
            itemColor: Colors.white,
            style: GoogleFonts.montserrat(color: Colors.white),
            onSubmitted: (value) {},
          ),
          bottom: PreferredSize(
            preferredSize: Size(MediaQuery.of(context).size.width, 40),
            child: SizedBox.fromSize(
              size: Size(MediaQuery.of(context).size.width, 40),
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Center(child: Text("Vị trí "));
                  }),
            ),
          ),
        ),
        body: BlocConsumer<JobsListViewModel, JobsListState>(
          bloc: _viewModel,
          listener: (context, state) {
            if (state.status == JobsListStatus.error) {
              Utils.showSnackBar(context, "Đã có lỗi xảy ra");
            }
          },
          builder: (context, state) {
            if (state.status == JobsListStatus.loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state.jobs.isEmpty) {
              return Center(
                child: Text("Không có công việc nào!"),
              );
            }
            return SmartRefresher(
              controller: _refreshController,
              onRefresh: () {
                _viewModel.getJobs(true);
              },
              onLoading: () {
                _viewModel.getJobs();
              },
              child: ListView.builder(
                  itemCount: state.jobs.length,
                  itemBuilder: (context, index) {
                    final data = state.jobs[index];
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 8),
                            child: Row(
                              children: [
                                AvatarWidget(
                                    avatar: data.poster?.avatar, size: 24),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  data.poster?.name ?? "",
                                  style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14),
                                )
                              ],
                            ),
                          ),
                          Divider(
                            height: 1,
                            color: AppColor.black,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 8),
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
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: AppColor.primaryColor
                                          .withOpacity(0.3)),
                                  child: Text("IT"),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: AppColor.primaryColor
                                          .withOpacity(0.3)),
                                  child: Text(
                                    "IT",
                                    style: GoogleFonts.montserrat(
                                        color: AppColor.primaryColor,
                                        fontSize: 12),
                                  ),
                                ),
                              ],
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
                                  "còn 14 ngày",
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
                                  "Hà Đông, Hà Nội",
                                  style: GoogleFonts.montserrat(fontSize: 14),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  }),
            );
          },
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
