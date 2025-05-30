// lib/domain/usecases/add_transaction.dart
import '../entities/transaction.dart';
import '../repositories/transaction_repository.dart';

class AddTransactionUseCase {
  final TransactionRepository repository;

  AddTransactionUseCase(this.repository);

  Future<void> call(TransactionEntity transaction) async {
    await repository.addTransaction(transaction);
  }
}
