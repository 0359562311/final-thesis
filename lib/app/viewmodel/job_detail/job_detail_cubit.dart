import 'package:fakeslink/app/model/repositories/job_repository.dart';
import 'package:fakeslink/app/model/request/create_my_job_request.dart';
import 'package:fakeslink/app/viewmodel/job_detail/job_detail_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class JobDetailCubit extends Cubit<JobDetailState> {
  final JobRepository _jobDetailRepository = JobRepositoryImpl();

  JobDetailCubit()
      : super(JobDetailState(status: JobDetailStatus.loading, jobDetail: null));

  void getJobDetail({int? jobDetailId}) {
    emit(state.copyWith(status: JobDetailStatus.loading));
    _jobDetailRepository.getJobDetail(jobDetailId ?? 0).then((value) {
      emit(state.copyWith(status: JobDetailStatus.success, jobDetail: value));
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
          jobDetail: state.jobDetail));
    }).catchError((onError) {
      emit(state.copyWith(status: JobDetailStatus.error, offers: state.offers));
    });
  }

  void getSameJob({int? categories, int? offset}) {
    emit(state.copyWith(status: JobDetailStatus.loading));
    _jobDetailRepository
        .getSameJob(categories: categories, offset: offset)
        .then((value) {
      emit(state.copyWith(
          status: JobDetailStatus.success, sameJobResponse: value));
    }).catchError((onError) {
      emit(state.copyWith(
          status: JobDetailStatus.error,
          sameJobResponse: state.sameJobResponse));
    });
  }

  void getMyOffer({int? offerId}) {
    emit(JobDetailState(
        status: JobDetailStatus.loading,
        jobDetail: state.jobDetail,
        sameJobResponse: state.sameJobResponse,
        offers: state.offers));
    _jobDetailRepository.getMyOffers(offerId: offerId).then((value) {
      emit(JobDetailState(
          status: JobDetailStatus.success,
          myOfferResponse: value,
          jobDetail: state.jobDetail));
    }).catchError((onError) {
      emit(JobDetailState(status: JobDetailStatus.error));
    });
  }

  void createMyJob({int? jobId, String? description, String? price}) {
    emit(JobDetailState(
        status: JobDetailStatus.loading,
        jobDetail: state.jobDetail,
        myOfferResponse: state.myOfferResponse,
        sameJobResponse: state.sameJobResponse,
        offers: state.offers));
    _jobDetailRepository
        .createMyJob(
            CreateMyJobRequest(
                price: int.parse(price ?? ""), description: description),
            jobId: jobId)
        .then((value) {
      emit(JobDetailState(
          status: JobDetailStatus.createMyJobSuccess,
          jobDetail: state.jobDetail,
          myOfferResponse: state.myOfferResponse,
          sameJobResponse: state.sameJobResponse,
          offers: state.offers));
    }).catchError((onError) {
      emit(JobDetailState(status: JobDetailStatus.error));
    });
  }
}
