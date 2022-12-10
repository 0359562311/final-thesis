import 'package:fakeslink/app/viewmodel/home/activities_tab/job_history/job_history_state.dart';
import 'package:fakeslink/app/viewmodel/home/activities_tab/job_history/job_history_viewmodel.dart';
import 'package:fakeslink/core/custom_widgets/job_item.dart';
import 'package:fakeslink/core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class JobHistoryPage extends StatefulWidget {
  const JobHistoryPage({Key? key}) : super(key: key);

  @override
  State<JobHistoryPage> createState() => _JobHistoryPageState();
}

class _JobHistoryPageState extends State<JobHistoryPage>
    with AutomaticKeepAliveClientMixin<JobHistoryPage> {
  late final RefreshController _controller;
  late final JobHistoryViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _controller = RefreshController();
    _viewModel = JobHistoryViewModel();
    _viewModel.getJobs(true);
  }

  @override
  void dispose() {
    _controller.dispose();
    _viewModel.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<JobHistoryViewModel, JobHistoryState>(
      bloc: _viewModel,
      listener: (context, state) {
        if (state.status == JobHistoryStatus.error) {
          Utils.showSnackBar(context, "Đã có lỗi xảy ra");
        }
      },
      builder: (context, state) {
        if (state.status == JobHistoryStatus.loading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state.jobs.isEmpty) {
          return Center(
            child: Text(
              "Không có dữ liệu!",
              style: GoogleFonts.montserrat(
                fontSize: 14,
              ),
            ),
          );
        }
        return SmartRefresher(
          controller: _controller,
          enablePullUp: true,
          onRefresh: () => _viewModel.getJobs(true),
          onLoading: () => _viewModel.getJobs(false),
          child: ListView.builder(
            itemCount: state.jobs.length,
            itemBuilder: (context, index) {
              return JobItem(data: state.jobs[index]);
            },
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
