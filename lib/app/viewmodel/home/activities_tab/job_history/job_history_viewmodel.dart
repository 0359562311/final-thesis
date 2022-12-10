import 'package:fakeslink/app/model/repositories/job_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'job_history_state.dart';

class JobHistoryViewModel extends Cubit<JobHistoryState> {
  final JobRepository _repository = JobRepositoryImpl();
  JobHistoryViewModel()
      : super(JobHistoryState(
            jobs: [], currentPage: 0, status: JobHistoryStatus.loading));

  void getJobs([bool isRefresh = false]) {
    if (isRefresh && state.jobs.isEmpty) {
      emit(state.copyWith(status: JobHistoryStatus.loading));
    }
    if (isRefresh) {
      state.currentPage = 0;
    }
    _repository.getMyJobs(state.currentPage + 1).then((value) {
      if (isRefresh) state.jobs.clear();
      int newPage = state.currentPage + 1;
      if (value.isEmpty) {
        newPage--;
      }
      emit(state.copyWith(
          jobs: state.jobs..addAll(value),
          status: JobHistoryStatus.success,
          currentPage: newPage));
    }).catchError((_) {
      emit(state.copyWith(status: JobHistoryStatus.error));
    });
  }
}
