import 'package:fakeslink/app/model/data_sources/offer_remote_source.dart';
import 'package:fakeslink/app/model/request/pay_offer_request.dart';
import 'package:fakeslink/app/model/request/review_response.dart';

import '../entities/offers.dart';
import '../entities/transaction.dart';
import '../request/accept_offers.dart';
import '../request/create_my_job_request.dart';

mixin OfferRepository {
  Future<List<Offer>> getOffers(int id);
  Future<Offer?> getMyOffers({int? jobId});
  Future<dynamic> createMyOffer(CreateMyOfferRequest request, {int? jobId});
  Future<dynamic> acceptOffer(AcceptOfferRequest request, {int? jobId});
  Future<dynamic> cancelOffer(int jobId);
  Future<Transaction> pay(PayOfferRequest request, {int? jobId});
  Future<dynamic> review(ReviewRequest request, {int? jobId});
}

class OfferRepositoryImpl implements OfferRepository {
  final OfferRemoteSource _offerRemoteSource = OfferRemoteSource();
  @override
  Future<Offer?> getMyOffers({int? jobId}) {
    return _offerRemoteSource.getMyOffers(offerId: jobId);
  }

  @override
  Future<dynamic> createMyOffer(CreateMyOfferRequest request, {int? jobId}) {
    return _offerRemoteSource.createMyOffer(request, jobId: jobId);
  }

  @override
  Future<dynamic> acceptOffer(AcceptOfferRequest request, {int? jobId}) {
    return _offerRemoteSource.acceptOffer(request, jobId: jobId);
  }

  @override
  Future cancelOffer(int jobId) {
    return _offerRemoteSource.cancelOffer(jobId);
  }

  @override
  Future<List<Offer>> getOffers(int id) {
    return _offerRemoteSource.getOffers(id);
  }

  @override
  Future<Transaction> pay(PayOfferRequest request, {int? jobId}) {
    return _offerRemoteSource.pay(request, jobId: jobId);
  }

  @override
  Future<dynamic> review(ReviewRequest request, {int? jobId}) {
    return _offerRemoteSource.review(request, jobId: jobId);
  }
}
