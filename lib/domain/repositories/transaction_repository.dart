// lib/domain/repositories/transaction_repository.dart
import '../entities/transaction.dart';

abstract class TransactionRepository {
  Future<void> addTransaction(TransactionEntity transaction);
  Future<List<TransactionEntity>> getTransactions();
  Future<void> deleteTransaction(String id);
}
