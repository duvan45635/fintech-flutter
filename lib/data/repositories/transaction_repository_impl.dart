// lib/data/repositories/transaction_repository_impl.dart
import '../../domain/entities/transaction.dart';
import '../../domain/repositories/transaction_repository.dart';
import '../datasources/local_datasource.dart';
import '../models/transaction_model.dart';

class TransactionRepositoryImpl implements TransactionRepository {
  final LocalDataSource localDataSource;

  TransactionRepositoryImpl({required this.localDataSource});

  @override
  Future<void> addTransaction(TransactionEntity transaction) {
    final model = TransactionModel.fromEntity(transaction);
    return localDataSource.addTransaction(model);
  }

  @override
  Future<List<TransactionEntity>> getTransactions() async {
    final models = await localDataSource.getTransactions();
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<void> deleteTransaction(String id) {
    return localDataSource.deleteTransaction(id);
  }
}
