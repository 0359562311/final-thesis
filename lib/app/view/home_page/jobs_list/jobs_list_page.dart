import 'package:fakeslink/app/view/create_job/create_job.dart';
import 'package:fakeslink/app/viewmodel/home/jobs_list_tab/jobs_list_cubit.dart';
import 'package:fakeslink/app/viewmodel/home/jobs_list_tab/jobs_list_state.dart';
import 'package:fakeslink/core/const/app_colors.dart';
import 'package:fakeslink/core/custom_widgets/circle_avatar_widget.dart';
import 'package:fakeslink/core/custom_widgets/job_item.dart';
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
    _viewModel.getJobs(
        true, _viewModel.state.categories?.map((e) => e.id ?? 0).toList());
    _viewModel.getCity();
    _viewModel.getCategory();
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
            itemColor: Colors.black,
            backgroundColor: Colors.white,
            style: GoogleFonts.montserrat(color: Colors.black),
            onSubmitted: (value) {},
          ),
          bottom: PreferredSize(
            preferredSize: Size(MediaQuery.of(context).size.width, 40),
            child: SizedBox.fromSize(
              size: Size(MediaQuery.of(context).size.width, 40),
              child: BlocBuilder<JobsListViewModel, JobsListState>(
                bloc: _viewModel,
                builder: (context, state) {
                  return Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          buildSelectedAddress(context, callBack: (index) {
                            Navigator.pop(context);
                            _viewModel.selectedCity(
                                name: _viewModel.cities[index]['name'],
                                code: _viewModel.cities[index]['code']);
                          }, list: _viewModel.cities);
                        },
                        child: Container(
                          width: 220,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              //   border: Border.all(color: AppColor.white),
                              borderRadius: BorderRadius.circular(8)),
                          child: Row(
                            children: [
                              Expanded(
                                  child: Text(
                                      _viewModel.cityName ??
                                          "Chọn tỉnh/ thành phố",
                                      style: GoogleFonts.montserrat(
                                        color: Colors.white,
                                      ))),
                              const Icon(
                                Icons.arrow_drop_down,
                                color: AppColor.white,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            buildSelectedCategory(context);
                          },
                          child: Container(
                            width: 220,
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                //   border: Border.all(color: AppColor.white),
                                borderRadius: BorderRadius.circular(8)),
                            child: Row(
                              children: [
                                Expanded(
                                    child: Text(
                                        _viewModel.categoryName ??
                                            "Chọn Category",
                                        style: GoogleFonts.montserrat(
                                          color: Colors.white,
                                        ))),
                                const Icon(
                                  Icons.arrow_drop_down,
                                  color: AppColor.white,
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  );
                },
              ),
            ),
          ),
        ),
        body: BlocConsumer<JobsListViewModel, JobsListState>(
          bloc: _viewModel,
          listener: (context, state) {
            if (state.status == JobsListStatus.error) {
              Utils.showSnackBar(context, "Đã có lỗi xảy ra");
            } else if (state.status == JobsListStatus.success) {
              _refreshController.refreshCompleted();
            }
          },
          builder: (context, state) {
            Widget? child;
            if (state.status == JobsListStatus.loading) {
              child = Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state.jobs.isEmpty) {
              child = Center(
                child: Text("Không có công việc nào!"),
              );
            }
            return SmartRefresher(
              controller: _refreshController,
              enablePullUp: true,
              onRefresh: () {
                _viewModel.getJobs(true);
              },
              onLoading: () {
                _viewModel.getJobs();
              },
              child: child != null
                  ? SingleChildScrollView(
                      child: child,
                    )
                  : ListView.builder(
                      itemCount: state.jobs.length,
                      itemBuilder: (context, index) {
                        final data = state.jobs[index];
                        return JobItem(data: data);
                      }),
            );
          },
        ),
      ),
    );
  }

  Future<dynamic> buildSelectedAddress(BuildContext context,
      {List<dynamic>? list, required OnTab callBack}) {
    return showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(10),
          ),
        ),
        builder: (context) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 5, top: 5),
                child: Align(
                  child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: const Icon(Icons.close)),
                  alignment: Alignment.centerRight,
                ),
              ),
              Expanded(
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: list?.length ?? 0,
                  itemBuilder: (context, int index) {
                    return GestureDetector(
                      onTap: () {
                        callBack(index);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 16, bottom: 10, top: 10),
                        child: Text(
                          list?[index]['name_with_type'],
                          style: GoogleFonts.montserrat(
                              color: AppColor.primaryColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 14),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return Container(
                      height: 1,
                      color: Colors.grey.shade200,
                    );
                  },
                ),
              ),
            ],
          );
        });
  }

  Future<dynamic> buildSelectedCategory(
    BuildContext context,
  ) {
    return showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(10),
          ),
        ),
        builder: (context) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 5, top: 5),
                child: Align(
                  child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: const Icon(Icons.close)),
                  alignment: Alignment.centerRight,
                ),
              ),
              Expanded(
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: _viewModel.state.categories?.length ?? 0,
                  itemBuilder: (context, int index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        _viewModel.selectedCategory(
                            name: _viewModel.state.categories?[index].name,
                            categoryId: _viewModel.state.categories?[index].id);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 16, bottom: 10, top: 10),
                        child: Text(
                          _viewModel.state.categories?[index].name ?? "",
                          style: GoogleFonts.montserrat(
                              color: AppColor.primaryColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 14),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return Container(
                      height: 1,
                      color: Colors.grey.shade200,
                    );
                  },
                ),
              ),
            ],
          );
        });
  }

  @override
  bool get wantKeepAlive => true;
}
