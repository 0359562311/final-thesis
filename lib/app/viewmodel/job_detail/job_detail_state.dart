import 'package:fakeslink/app/model/entities/job.dart';
import 'package:fakeslink/app/model/entities/my_offer.dart';
import 'package:fakeslink/app/model/entities/offers.dart';
import 'package:fakeslink/app/model/entities/same_job.dart';

enum JobDetailStatus { loading, success, error, createMyJobSuccess }

class JobDetailState {
  final Job? jobDetail;
  final JobDetailStatus status;
  final List<OffersResponse>? offers;
  final SameJobResponse? sameJobResponse;
  final MyOfferResponse? myOfferResponse;

  JobDetailState(
      {this.jobDetail,
      required this.status,
      this.offers,
      this.sameJobResponse,
      this.myOfferResponse});

  JobDetailState copyWith(
      {Job? jobDetail,
      JobDetailStatus? status,
      List<OffersResponse>? offers,
      SameJobResponse? sameJobResponse,
      MyOfferResponse? myOfferResponse}) {
    return JobDetailState(
        jobDetail: jobDetail ?? this.jobDetail,
        status: status ?? this.status,
        offers: offers ?? this.offers,
        sameJobResponse: sameJobResponse ?? this.sameJobResponse,
        myOfferResponse: myOfferResponse ?? this.myOfferResponse);
  }
}
