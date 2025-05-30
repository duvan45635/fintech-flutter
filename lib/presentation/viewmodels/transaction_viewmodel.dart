import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/transaction_model.dart';
import '../../main.dart';

final transactionViewModelProvider = StateNotifierProvider<TransactionViewModel, List<TransactionModel>>((ref) {
  final repo = ref.watch(transactionRepositoryProvider);
  return TransactionViewModel(repo);
});

class TransactionViewModel extends StateNotifier<List<TransactionModel>> {
  final repository;
  TransactionViewModel(this.repository) : super([]) {
    loadTransactions();
  }

  Future<void> loadTransactions() async {
    state = await repository.getTransactions();
  }

  Future<void> addTransaction(TransactionModel t) async {
    await repository.addTransaction(t);
    state = [...state, t];
  }

  Future<void> deleteTransaction(String id) async {
    await repository.deleteTransaction(id);
    state = state.where((t) => t.hiveId != id).toList();
  }
}
