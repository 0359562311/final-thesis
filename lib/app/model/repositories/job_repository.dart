import 'package:fakeslink/app/model/data_sources/job_remote_source.dart';
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
}
