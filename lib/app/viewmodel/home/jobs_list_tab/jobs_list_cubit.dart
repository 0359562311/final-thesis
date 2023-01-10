import 'dart:convert';

import 'package:fakeslink/app/model/repositories/job_repository.dart';
import 'package:fakeslink/app/model/request/filter_job_request.dart';
import 'package:fakeslink/app/viewmodel/home/jobs_list_tab/jobs_list_state.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum JobsListStatus { loading, success, error }

class JobsListViewModel extends Cubit<JobsListState> {
  final JobRepository _repository = JobRepositoryImpl();

  JobsListViewModel()
      : super(
            JobsListState(jobs: [], status: JobsListStatus.loading, offset: 0));
  String? cityName;
  String? categoryName;
  int? category;
  List<dynamic> cities = [];

  void getJobs([bool isRefresh = false, List<int>? category]) {
    if (isRefresh) {
      emit(state.copyWith(offset: 0, status: JobsListStatus.loading));
    }
    _repository
        .getJobs(FilterJob(
            offset: state.offset,
            keyword: state.searchKey,
            categories: category))
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

  void getCity() async {
    try {
      emit(state.copyWith(
        status: JobsListStatus.loading,
      ));
      String response = await rootBundle.loadString('assets/json/city.json');
      var data = await json.decode(response);
      data = data as Map;
      data.forEach((key, value) {
        cities.add(value);
      });
      emit(state.copyWith(
        status: JobsListStatus.success,
      ));
    } catch (e) {}
  }

  void getCategory() {
    _repository.getCategory().then((value) {
      emit(state.copyWith(status: JobsListStatus.success, categories: value));
    }).catchError((onError) {
      emit(state.copyWith(status: JobsListStatus.error));
    });
  }

  void selectedCity({String? name, String? code}) {
    emit(state.copyWith(
      status: JobsListStatus.loading,
    ));
    cityName = name;
    emit(state.copyWith(status: JobsListStatus.success));
  }

  void selectedCategory({String? name, int? categoryId}) {
    emit(state.copyWith(
      status: JobsListStatus.loading,
    ));
    categoryName = name;
    category = categoryId;
    getJobs(true, [category ?? 0]);
    emit(state.copyWith(status: JobsListStatus.success));
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
