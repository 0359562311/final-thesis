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

  Future done(Transaction transaction, status) {
    return GetIt.I<Dio>().put("/transaction/", data: {
      "detail": transaction.deposit?.detail ?? transaction.withdraw?.detail,
      "key":
          r"django-insecure--!3w7_fk7g%kd#4%_=30b6x(7^&l%5)zn4$vmnzvc_*6gisw4b",
      "status": status ? "Success" : "Failed"
    });
  }
}
