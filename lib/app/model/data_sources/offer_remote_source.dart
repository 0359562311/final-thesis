import 'package:dio/dio.dart';
import 'package:fakeslink/app/model/entities/offers.dart';
import 'package:fakeslink/app/model/entities/transaction.dart';
import 'package:fakeslink/app/model/request/pay_offer_request.dart';
import 'package:fakeslink/app/model/request/review_response.dart';
import 'package:get_it/get_it.dart';

import '../request/accept_offers.dart';
import '../request/create_my_job_request.dart';

class OfferRemoteSource {
  Future<Offer?> getMyOffers({int? offerId}) async {
    final res = (await GetIt.I<Dio>().get("/job/$offerId/my_offer")).data;
    if (res is! Map<String, dynamic>) return null;
    return Offer.fromJson(res);
  }

  Future<dynamic> createMyOffer(CreateMyOfferRequest request,
      {int? jobId}) async {
    final res = (await GetIt.I<Dio>()
            .post("/job/$jobId/my_offer/", data: request.toJson()))
        .data;
    return res;
  }

  Future<dynamic> acceptOffer(AcceptOfferRequest request, {int? jobId}) async {
    final res = (await GetIt.I<Dio>()
            .put("/job/$jobId/accept_offer/", data: request.toJson()))
        .data;
    return res;
  }

  Future cancelOffer(int jobId) async {
    final res = (await GetIt.I<Dio>()
            .patch("/job/$jobId/my_offer/", data: {"status": "Closed"}))
        .data;
    return res;
  }

  Future<List<Offer>> getOffers(int id) async {
    final res = (await GetIt.I<Dio>().get(
      "/job/$id/offers",
    ))
        .data;
    return (res as List).map((e) => Offer.fromJson(e)).toList();
  }

  Future<Transaction> pay(PayOfferRequest request, {int? jobId}) async {
    final res = (await GetIt.I<Dio>()
            .post("/payment/$jobId/jobPayment/", data: request.toJson()))
        .data;
    return Transaction.fromJson(res);
  }

  Future<dynamic> review(ReviewRequest request, {int? jobId}) async {
    final res = (await GetIt.I<Dio>()
            .post("/job/$jobId/review/", data: request.toJson()))
        .data;
    return res;
  }
}
