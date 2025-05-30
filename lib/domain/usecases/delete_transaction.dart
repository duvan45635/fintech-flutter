// lib/domain/usecases/delete_transaction.dart
import '../repositories/transaction_repository.dart';

class DeleteTransactionUseCase {
  final TransactionRepository repository;

  DeleteTransactionUseCase(this.repository);

  Future<void> call(String id) async {
    await repository.deleteTransaction(id);
  }
}
