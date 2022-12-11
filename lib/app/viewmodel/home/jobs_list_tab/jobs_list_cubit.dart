import 'package:fakeslink/app/model/repositories/job_repository.dart';
import 'package:fakeslink/app/model/request/filter_job_request.dart';
import 'package:fakeslink/app/viewmodel/home/jobs_list_tab/jobs_list_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum JobsListStatus { loading, success, error }

class JobsListViewModel extends Cubit<JobsListState> {
  final JobRepository _repository = JobRepositoryImpl();

  JobsListViewModel()
      : super(
            JobsListState(jobs: [], status: JobsListStatus.loading, offset: 0));

  void getJobs([
    bool isRefresh = false,
  ]) {
    if (isRefresh) {
      emit(state.copyWith(offset: 0, status: JobsListStatus.loading));
    }
    _repository
        .getJobs(FilterJob(
            offset: state.offset,
            keyword: state.searchKey,
            categories: state.categories?.map((e) => e.id ?? 0).toList()))
        .then((value) {
      if (isRefresh) state.jobs.clear();
      emit(state.copyWith(
          jobs: state.jobs..addAll(value),
          status: JobsListStatus.success,
          offset: state.offset + value.length));
    }).catchError((e) {
      emit(state.copyWith(status: JobsListStatus.error, offset: state.offset));
    });
  }

  void search(String keyword) {
    if (keyword != state.searchKey) {
      state.searchKey = keyword;
      getJobs(true);
    }
  }

  void applyAddress() {}

  void applyCategories() {}
}
