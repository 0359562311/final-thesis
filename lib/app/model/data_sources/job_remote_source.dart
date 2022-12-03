import 'package:dio/dio.dart';
import 'package:fakeslink/app/model/dto/filter_job.dart';
import 'package:fakeslink/app/model/entities/category.dart';
import 'package:fakeslink/app/model/entities/job.dart';
import 'package:get_it/get_it.dart';

class JobRemoteSource {
  Future<List<Category>> getCategory() async {
    final res = (await GetIt.I<Dio>().get("/job/categories")).data;
    return (res as List).map((e) => Category.fromJson(e)).toList();
  }

  Future<List<Job>> getJobs(FilterJob filterJob) async {
    final res =
        (await GetIt.I<Dio>().get("/job", queryParameters: filterJob.toMap()))
            .data['results'];
    return (res as List).map((e) => Job.fromJson(e)).toList();
  }
}
