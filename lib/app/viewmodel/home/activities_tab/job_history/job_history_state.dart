import 'package:fakeslink/app/model/entities/job.dart';

enum JobHistoryStatus { error, loading, success }

class JobHistoryState {
  List<Job> jobs;
  int offset;
  JobHistoryStatus status;

  JobHistoryState({
    required this.jobs,
    required this.offset,
    required this.status,
  });

  JobHistoryState copyWith({
    List<Job>? jobs,
    int? currentPage,
    JobHistoryStatus? status,
  }) {
    return JobHistoryState(
      jobs: jobs ?? this.jobs,
      offset: currentPage ?? this.offset,
      status: status ?? this.status,
    );
  }
}
