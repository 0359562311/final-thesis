import 'package:fakeslink/app/model/repositories/job_repository.dart';
import 'package:fakeslink/app/model/request/filter_job_request.dart';
import 'package:fakeslink/app/viewmodel/home/jobs_list/jobs_list_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum JobsListStatus { loading, success, error }

class JobsListViewModel extends Cubit<JobsListState> {
  final JobRepository _repository = JobRepositoryImpl();

  JobsListViewModel()
      : super(JobsListState(
            jobs: [], status: JobsListStatus.loading, currentPage: 1));

  void getJobs([
    bool isRefresh = false,
  ]) {
    if (isRefresh) {
      emit(state.copyWith(currentPage: 0, status: JobsListStatus.loading));
    }
    _repository
        .getJobs(FilterJob(
            page: state.currentPage + 1,
            keyword: state.searchKey,
            categories: state.categories?.map((e) => e.id ?? 0).toList()))
        .then((value) {
      if (isRefresh) state.jobs.clear();
      emit(state.copyWith(
          jobs: state.jobs..addAll(value),
          status: JobsListStatus.success,
          currentPage: state.currentPage + 1));
    }).catchError((e) {
      emit(state.copyWith(
          status: JobsListStatus.error, currentPage: state.currentPage));
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
