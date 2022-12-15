// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fakeslink/app/model/entities/category.dart';
import 'package:fakeslink/app/model/entities/job.dart';
import 'package:fakeslink/app/model/entities/transaction.dart';

enum HomeStatus {
  loading,
  error,
  success,
  initial,
  depositSuccess,
  withdrawSuccess
}

class HomeState {
  final HomeStatus status;
  final List<Category>? category;
  final List<Job>? jobs;
  int currentTab;
  Transaction? transaction;

  HomeState(
    this.status,
    this.category,
    this.jobs,
    this.currentTab,
    this.transaction,
  );

  HomeState copyWith({
    HomeStatus? status,
    List<Category>? category,
    List<Job>? jobs,
    int? currentTab,
    Transaction? transaction,
  }) {
    return HomeState(
      status ?? this.status,
      category ?? this.category,
      jobs ?? this.jobs,
      currentTab ?? this.currentTab,
      transaction ?? this.transaction,
    );
  }
}
