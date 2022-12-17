import 'package:fakeslink/app/model/repositories/job_repository.dart';
import 'package:fakeslink/app/model/request/create_my_job_request.dart';
import 'package:fakeslink/app/viewmodel/job_detail/job_detail_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class JobDetailViewModel extends Cubit<JobDetailState> {
  final JobRepository _jobDetailRepository = JobRepositoryImpl();

  JobDetailViewModel()
      : super(JobDetailState(status: JobDetailStatus.loading, jobDetail: null));

  void getJobDetail({int? jobDetailId}) {
    emit(state.copyWith(status: JobDetailStatus.loading));
    _jobDetailRepository.getJobDetail(jobDetailId ?? 0).then((value) {
      emit(state.copyWith(
        status: JobDetailStatus.success,
        jobDetail: value,
      ));
      getOffers(id: jobDetailId);
    }).catchError((e) {
      emit(state.copyWith(status: JobDetailStatus.error));
    });
  }

  void getOffers({int? id}) {
    emit(state.copyWith(
        status: JobDetailStatus.loading, jobDetail: state.jobDetail));
    _jobDetailRepository.getOffers(id ?? 0).then((value) {
      emit(state.copyWith(
        status: JobDetailStatus.success,
        offers: value,
      ));
    }).catchError((onError) {
      emit(state.copyWith(status: JobDetailStatus.error, offers: state.offers));
    });
  }

  void getSameJob({int? categories, int? offset}) {
    emit(state.copyWith(status: JobDetailStatus.loading));
    _jobDetailRepository
        .getSameJob(categories: categories, offset: offset)
        .then((value) {
      emit(state.copyWith(status: JobDetailStatus.success, sameJobs: value));
    }).catchError((onError) {
      emit(state.copyWith(
          status: JobDetailStatus.error, sameJobs: state.sameJobs));
    });
  }

  void getMyOffer({int? jobId}) {
    emit(JobDetailState(
        status: JobDetailStatus.loading,
        jobDetail: state.jobDetail,
        sameJobs: state.sameJobs,
        offers: state.offers));
    _jobDetailRepository.getMyOffers(jobId: jobId).then((value) {
      emit(state.copyWith(
          status: JobDetailStatus.success,
          myOffer: value,
          jobDetail: state.jobDetail,
          offers: state.offers,
          sameJobs: state.sameJobs));
    }).catchError((onError) {
      emit(state.copyWith(status: JobDetailStatus.error));
    });
  }

  void createMyJob({int? jobId, String? description, String? price}) {
    emit(JobDetailState(
      status: JobDetailStatus.loading,
    ));
    _jobDetailRepository
        .createMyJob(
            CreateMyJobRequest(
                price: int.parse(price ?? ""), description: description),
            jobId: jobId)
        .then((value) {
      emit(state.copyWith(
        status: JobDetailStatus.createOfferSuccess,
      ));
    }).catchError((onError) {
      emit(state.copyWith(status: JobDetailStatus.error));
    });
  }
}
