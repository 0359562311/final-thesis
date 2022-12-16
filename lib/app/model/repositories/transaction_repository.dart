import 'package:fakeslink/app/model/data_sources/transaction_remote_source.dart';
import 'package:fakeslink/app/model/entities/transaction.dart';

abstract class TransactionRepository {
  Future<Transaction> deposit(int amount);
  Future<Transaction> withdraw(int amount);
  Future<Transaction> getById(int id);
  Future<List<Transaction>> getAll(int offset);
  Future done(Transaction transaction, status);
}

class TransactionRepositoryImpl extends TransactionRepository {
  final TransactionRemoteSource _remoteSource = TransactionRemoteSource();
  @override
  Future<Transaction> deposit(int amount) {
    return _remoteSource.deposit(amount);
  }

  @override
  Future<Transaction> withdraw(int amount) {
    return _remoteSource.withdraw(amount);
  }

  @override
  Future<Transaction> getById(int id) {
    return _remoteSource.getById(id);
  }

  @override
  Future<List<Transaction>> getAll(int offset) {
    return _remoteSource.getAll(offset);
  }

  @override
  Future done(Transaction transaction, status) {
    return _remoteSource.done(transaction, status);
  }
}
