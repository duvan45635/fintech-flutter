// lib/data/datasources/local_datasource.dart
import 'package:hive/hive.dart';
import '../models/transaction_model.dart';

abstract class LocalDataSource {
  Future<void> addTransaction(TransactionModel transaction);
  Future<List<TransactionModel>> getTransactions();
  Future<void> deleteTransaction(String id);
}

class HiveLocalDataSource implements LocalDataSource {
  final Box<TransactionModel> box;

  HiveLocalDataSource(this.box);

  @override
  Future<void> addTransaction(TransactionModel transaction) async {
    await box.put(transaction.hiveId, transaction);
  }

  @override
  Future<List<TransactionModel>> getTransactions() async {
    return box.values.toList();
  }

  @override
  Future<void> deleteTransaction(String id) async {
    await box.delete(id);
  }
}
