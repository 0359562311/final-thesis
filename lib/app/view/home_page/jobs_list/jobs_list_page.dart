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

  @override
  bool get wantKeepAlive => true;
}
