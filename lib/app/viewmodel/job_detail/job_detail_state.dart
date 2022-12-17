import 'package:fakeslink/app/model/entities/job.dart';
import 'package:fakeslink/app/model/entities/my_offer.dart';
import 'package:fakeslink/app/model/entities/offers.dart';

enum JobDetailStatus { loading, success, error, createOfferSuccess }

class JobDetailState {
  final Job? jobDetail;
  final JobDetailStatus status;
  final List<Offer>? offers;
  final List<Job>? sameJobs;
  final MyOffer? myOffer;

  JobDetailState(
      {this.jobDetail,
      required this.status,
      this.offers,
      this.sameJobs,
      this.myOffer});

  JobDetailState copyWith(
      {Job? jobDetail,
      JobDetailStatus? status,
      List<Offer>? offers,
      List<Job>? sameJobs,
      MyOffer? myOffer}) {
    return JobDetailState(
        jobDetail: jobDetail ?? this.jobDetail,
        status: status ?? this.status,
        offers: offers ?? this.offers,
        sameJobs: sameJobs ?? this.sameJobs,
        myOffer: myOffer ?? this.myOffer);
  }
}
