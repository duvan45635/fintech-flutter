// lib/domain/usecases/get_transactions.dart
import '../entities/transaction.dart';
import '../repositories/transaction_repository.dart';

class GetTransactionsUseCase {
  final TransactionRepository repository;

  GetTransactionsUseCase(this.repository);

  Future<List<TransactionEntity>> call() async {
    return await repository.getTransactions();
  }
}
