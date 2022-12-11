import 'package:fakeslink/app/model/entities/address.dart';
import 'package:fakeslink/app/model/entities/category.dart';
import 'package:fakeslink/app/model/entities/job.dart';
import 'package:fakeslink/app/viewmodel/home/jobs_list_tab/jobs_list_cubit.dart';

class JobsListState {
  List<Job> jobs;
  String? searchKey;
  Address? selectedAddress;
  List<Category>? categories;
  JobsListStatus status;
  int offset;

  JobsListState({
    required this.jobs,
    this.searchKey,
    this.selectedAddress,
    this.categories,
    required this.status,
    required this.offset,
  });

  JobsListState copyWith({
    List<Job>? jobs,
    String? searchKey,
    Address? selectedAddress,
    List<Category>? categories,
    JobsListStatus? status,
    int? offset,
  }) {
    return JobsListState(
      jobs: jobs ?? this.jobs,
      searchKey: searchKey ?? this.searchKey,
      selectedAddress: selectedAddress ?? this.selectedAddress,
      categories: categories ?? this.categories,
      status: status ?? this.status,
      offset: offset ?? this.offset,
    );
  }
}
