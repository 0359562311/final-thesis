import 'package:dio/dio.dart';
import 'package:fakeslink/app/model/entities/transaction.dart';
import 'package:get_it/get_it.dart';

class TransactionRemoteSource {
  Future<Transaction> deposit(int amount) async {
    final res = await GetIt.I<Dio>()
        .post("/payment/deposit/", data: {"amount": amount});
    return Transaction.fromJson(res.data);
  }

  Future<Transaction> withdraw(int amount) async {
    final res = await GetIt.I<Dio>()
        .post("/payment/withdraw/", data: {"amount": amount});
    return Transaction.fromJson(res.data);
  }
}
