import 'package:fakeslink/app/model/data_sources/job_remote_source.dart';
import 'package:fakeslink/app/model/entities/my_offer.dart';
import 'package:fakeslink/app/model/entities/offers.dart';
import 'package:fakeslink/app/model/request/accept_offers.dart';
import 'package:fakeslink/app/model/request/create_my_job_request.dart';
import 'package:fakeslink/app/model/request/filter_job_request.dart';
import 'package:fakeslink/app/model/entities/category.dart';
import 'package:fakeslink/app/model/entities/job.dart';
import 'package:fakeslink/app/model/entities/payment.dart';
import 'package:fakeslink/app/model/request/create_job_request.dart';

mixin JobRepository {
  Future<List<Category>> getCategory();
  Future<List<PaymentMethod>> getPayment();
  Future<dynamic> createJob(CreteJobRequest request);
  Future<List<Job>> getJobs(FilterJob filterJob);
  Future<List<Job>> getMyJobs(int page);
  Future<Job> getJobDetail(int jobDetailId);
  Future<List<Offer>> getOffers(int id);
  Future<List<Job>> getSameJob({int? categories, int? offset});
  Future<MyOffer?> getMyOffers({int? jobId});
  Future<dynamic> createMyJob(CreateMyJobRequest request, {int? jobId});
  Future<dynamic> acceptOffer(AcceptOffers request, {int? jobId});
}

class JobRepositoryImpl implements JobRepository {
  final JobRemoteSource _jobRemoteSource = JobRemoteSource();
  @override
  Future<List<Category>> getCategory() {
    return _jobRemoteSource.getCategory();
  }

  @override
  Future<List<Job>> getJobs(FilterJob filterJob) {
    return _jobRemoteSource.getJobs(filterJob);
  }

  @override
  Future<List<PaymentMethod>> getPayment() {
    return _jobRemoteSource.getPayment();
  }

  @override
  Future<dynamic> createJob(CreteJobRequest request) {
    return _jobRemoteSource.createJob(request);
  }

  @override
  Future<List<Job>> getMyJobs(int offset) {
    return _jobRemoteSource.getMyJobs(offset);
  }

  @override
  Future<Job> getJobDetail(int jobDetailId) {
    return _jobRemoteSource.getJobDetail(jobDetailId);
  }

  @override
  Future<List<Offer>> getOffers(int id) {
    return _jobRemoteSource.getOffers(id);
  }

  @override
  Future<List<Job>> getSameJob({int? categories, int? offset}) {
    return _jobRemoteSource.getSameJob(categories: categories, offset: offset);
  }

  @override
  Future<MyOffer?> getMyOffers({int? jobId}) {
    return _jobRemoteSource.getMyOffers(offerId: jobId);
  }

  @override
  Future<dynamic> createMyJob(CreateMyJobRequest request, {int? jobId}) {
    return _jobRemoteSource.createMyJob(request, jobId: jobId);
  }

  @override
  Future<dynamic> acceptOffer(AcceptOffers request, {int? jobId}) {
    return _jobRemoteSource.acceptOffer(request, jobId: jobId);
  }
}
