import 'package:dio/dio.dart';
import 'package:fakeslink/app/model/entities/offers.dart';
import 'package:fakeslink/app/model/request/filter_job_request.dart';
import 'package:fakeslink/app/model/entities/category.dart';
import 'package:fakeslink/app/model/entities/job.dart';
import 'package:fakeslink/app/model/entities/payment.dart';
import 'package:fakeslink/app/model/request/create_job_request.dart';
import 'package:fakeslink/app/model/request/pay_offer_request.dart';
import 'package:get_it/get_it.dart';

class JobRemoteSource {
  Future<List<Category>> getCategory() async {
    final res = (await GetIt.I<Dio>().get("/job/categories")).data;
    return (res as List).map((e) => Category.fromJson(e)).toList();
  }

  Future<List<Job>> getJobs(FilterJob filterJob) async {
    final res =
        (await GetIt.I<Dio>().get("/job", queryParameters: filterJob.toJson()))
            .data['results'];
    return (res as List).map((e) => Job.fromJson(e)).toList();
  }

  Future<List<Job>> getMyJobs(int offset) async {
    final res = (await GetIt.I<Dio>()
            .get("/myJobs", queryParameters: {"offset": offset}))
        .data['results'];
    return (res as List).map((e) => Job.fromJson(e)).toList();
  }

  Future<List<PaymentMethod>> getPayment() async {
    final res = (await GetIt.I<Dio>().get("/job/payment_methods")).data;
    return (res as List).map((e) => PaymentMethod.fromJson(e)).toList();
  }

  Future<dynamic> createJob(CreteJobRequest request) async {
    final res =
        (await GetIt.I<Dio>().post("/job/", data: request.toJson())).data;
    return res;
  }

  Future<Job> getJobDetail(int jobDetailId) async {
    final res = (await GetIt.I<Dio>().get(
      "/job/$jobDetailId",
    ));
    return Job.fromJson(res.data);
  }

  Future<List<Job>> getSameJob({int? categories, int? offset}) async {
    final res = (await GetIt.I<Dio>().get("/job",
            queryParameters: {"categories": categories, "offset": offset}))
        .data;
    return res['results'].map<Job>((e) => Job.fromJson(e)).toList();
  }

  Future updateJobStatus(int jobId, JobStatus status) {
    return GetIt.I<Dio>()
        .patch("/job/$jobId/", queryParameters: {"status": status.name});
  }

  Future<List<Offer>> getOfferHistory() async {
    final res = (await GetIt.I<Dio>().get("/job/offered")).data;
    return (res as List).map((e) => Offer.fromJson(e)).toList();
  }
}
