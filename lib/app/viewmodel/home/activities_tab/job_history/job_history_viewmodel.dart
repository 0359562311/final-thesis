import 'package:fakeslink/app/model/repositories/job_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'job_history_state.dart';

class JobHistoryViewModel extends Cubit<JobHistoryState> {
  final JobRepository _repository = JobRepositoryImpl();
  JobHistoryViewModel()
      : super(JobHistoryState(
            jobs: [], offset: 0, status: JobHistoryStatus.loading));

  void getJobs([bool isRefresh = false]) {
    if (isRefresh && state.jobs.isEmpty) {
      emit(state.copyWith(status: JobHistoryStatus.loading));
    }
    if (isRefresh) {
      state.offset = 0;
    }
    _repository.getMyJobs(state.offset).then((value) {
      if (isRefresh) {
        state.jobs.clear();
        state.offset = 0;
      }
      emit(state.copyWith(
          jobs: state.jobs..addAll(value),
          status: JobHistoryStatus.success,
          currentPage: state.offset + value.length));
    }).catchError((_) {
      emit(state.copyWith(status: JobHistoryStatus.error));
    });
  }
}
