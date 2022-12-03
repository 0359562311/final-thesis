import 'package:fakeslink/app/model/data_sources/job_remote_source.dart';
import 'package:fakeslink/app/model/entities/category.dart';

mixin JobRepository {
  Future<List<Category>> getCategory();
}

class JobRepositoryImpl implements JobRepository {
  final JobRemoteSource _jobSource = JobRemoteSource();
  @override
  Future<List<Category>> getCategory() {
    return _jobSource.getCategory();
  }
}
