import 'package:fakeslink/app/model/entities/job.dart';
import 'package:fakeslink/app/model/repositories/job_repository.dart';
import 'package:fakeslink/app/model/repositories/offer_repository.dart';
import 'package:fakeslink/app/model/request/accept_offers.dart';
import 'package:fakeslink/app/model/request/create_my_job_request.dart';
import 'package:fakeslink/app/model/request/job_promotion_request.dart';
import 'package:fakeslink/app/viewmodel/job_detail/job_detail_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class JobDetailViewModel extends Cubit<JobDetailState> {
  final JobRepository _jobDetailRepository = JobRepositoryImpl();
  final OfferRepository _offerRepository = OfferRepositoryImpl();

  JobDetailViewModel()
      : super(JobDetailState(status: JobDetailStatus.loading, jobDetail: null));

  int? price;
  String? dueDate;

  void init(int jobId) {
    getJobDetail(jobDetailId: jobId);
    getMyOffer(jobId: jobId);
    getOffers(jobId: jobId);
  }

  void getJobDetail({int? jobDetailId}) {
    emit(state.copyWith(status: JobDetailStatus.loading));
    _jobDetailRepository.getJobDetail(jobDetailId ?? 0).then((value) {
      emit(state.copyWith(
        status: JobDetailStatus.success,
        jobDetail: value,
      ));
      getOffers(jobId: jobDetailId);
    }).catchError((e) {
      emit(state.copyWith(status: JobDetailStatus.error));
    });
  }

  void getOffers({int? jobId}) {
    emit(state.copyWith(
        status: JobDetailStatus.loading, jobDetail: state.jobDetail));
    _offerRepository.getOffers(jobId ?? 0).then((value) {
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
        status: JobDetailStatus.error,
      ));
    });
  }

  void getMyOffer({int? jobId}) {
    emit(state.copyWith(
      status: JobDetailStatus.loading,
    ));
    _offerRepository.getMyOffers(jobId: jobId).then((value) {
      emit(state.copyWith(
        status: JobDetailStatus.success,
        myOffer: value,
      ));
    }).catchError((onError) {
      emit(state.copyWith(status: JobDetailStatus.error));
    });
  }

  void createMyOffer({int? jobId, String? description, String? price}) {
    emit(state.copyWith(
      status: JobDetailStatus.loading,
    ));
    _offerRepository
        .createMyOffer(
            CreateMyOfferRequest(
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

  void closedOffer(int jobId) {
    emit(state.copyWith(status: JobDetailStatus.loading));
    _offerRepository.cancelOffer(jobId).then((value) {
      emit(state.copyWith(myOffer: null));
      getMyOffer(jobId: jobId);
    }).catchError((onError) {
      emit(state.copyWith(status: JobDetailStatus.error));
    });
  }

  void updateJobStatus(int jobId, JobStatus status) {
    _jobDetailRepository.updateJobStatus(jobId, status).then((value) {
      emit(state.copyWith(status: JobDetailStatus.loading));
      getJobDetail(jobDetailId: jobId);
    }).catchError((onError) {
      emit(state.copyWith(status: JobDetailStatus.error));
    });
  }

  int? priceAdvertisement({required int balance, required int day}) {
    price = balance * day;
    return price;
  }

  void createDay({int? day, int? jobId}) {
    emit(state.copyWith(status: JobDetailStatus.loading));
    _jobDetailRepository
        .jobPromotion(JobPromotionRequest(days: day, jobId: jobId))
        .then((value) {
      dueDate = value.jobPromotion?.dueDate;
      emit(state.copyWith(
          status: JobDetailStatus.updateDaySuccess, jobDetail: value));
    }).catchError((onError) {
      emit(state.copyWith(status: JobDetailStatus.error));
    });
  }
}
