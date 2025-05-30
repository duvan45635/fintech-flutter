import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/transaction_model.dart';
import '../viewmodels/transaction_viewmodel.dart';
import '../../core/enum/transaction_type.dart';

class AddTransactionPage extends ConsumerWidget {
  const AddTransactionPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final titleController = TextEditingController();
    final amountController = TextEditingController();
    TransactionType selectedType = TransactionType.expense;

    return Scaffold(
      appBar: AppBar(title: const Text("Añadir Transacción")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: titleController, decoration: const InputDecoration(labelText: "Título")),
            TextField(controller: amountController, decoration: const InputDecoration(labelText: "Monto"), keyboardType: TextInputType.number),
            DropdownButton<TransactionType>(
              value: selectedType,
              items: TransactionType.values.map((type) {
                return DropdownMenuItem(value: type, child: Text(type.name));
              }).toList(),
              onChanged: (value) => selectedType = value!,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final transaction = TransactionModel(
                  hiveId: DateTime.now().millisecondsSinceEpoch.toString(),
                  title: titleController.text,
                  amount: double.parse(amountController.text),
                  type: selectedType,
                  date: DateTime.now(),
                );
                ref.read(transactionViewModelProvider.notifier).addTransaction(transaction);
                Navigator.pop(context);
              },
              child: const Text("Guardar"),
            ),
          ],
        ),
      ),
    );
  }
}
