import 'package:fakeslink/app/model/entities/category.dart';
import 'package:fakeslink/app/model/entities/job.dart';

enum HomeStatus { loading, error, success, initial }

class HomeState {
  final HomeStatus status;
  final List<Category>? category;
  final List<Job>? jobs;
  int currentTab;

  HomeState(
      {required this.status, this.category, this.currentTab = 0, this.jobs});

  HomeState copyWith({
    HomeStatus? status,
    List<Category>? category,
    List<Job>? jobs,
    int? currentTab,
  }) {
    return HomeState(
      status: status ?? this.status,
      category: category ?? this.category,
      currentTab: currentTab ?? this.currentTab,
      jobs: jobs ?? this.jobs,
    );
  }
}
