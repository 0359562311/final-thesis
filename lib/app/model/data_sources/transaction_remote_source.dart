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

  Future<Transaction> getById(int id) async {
    final res = await GetIt.I<Dio>().get(
      "/payment/$id",
    );
    return Transaction.fromJson(res.data);
  }

  Future<List<Transaction>> getAll(int offset) async {
    final res = await GetIt.I<Dio>()
        .get("/payment/", queryParameters: {"offset": offset});
    return res.data['results']
        .map<Transaction>((e) => Transaction.fromJson(e))
        .toList();
  }
}
