import 'package:fakeslink/app/model/entities/job.dart';

enum JobHistoryStatus { error, loading, success }

class JobHistoryState {
  List<Job> jobs;
  int currentPage;
  JobHistoryStatus status;

  JobHistoryState({
    required this.jobs,
    required this.currentPage,
    required this.status,
  });

  JobHistoryState copyWith({
    List<Job>? jobs,
    int? currentPage,
    JobHistoryStatus? status,
  }) {
    return JobHistoryState(
      jobs: jobs ?? this.jobs,
      currentPage: currentPage ?? this.currentPage,
      status: status ?? this.status,
    );
  }
}
