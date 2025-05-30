import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../viewmodels/transaction_viewmodel.dart';
import '../widgets/transaction_list.dart';
import '../widgets/transaction_chart.dart';
import 'add_transaction_page.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transactions = ref.watch(transactionViewModelProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Mis Finanzas")),
      body: transactions.isEmpty
          ? const Center(child: Text("No hay transacciones"))
          : Column(
              children: [
                TransactionChart(transactions: transactions),
                Expanded(child: TransactionList(transactions: transactions)),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AddTransactionPage())),
        child: const Icon(Icons.add),
      ),
    );
  }
}
