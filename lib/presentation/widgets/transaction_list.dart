import 'package:flutter/material.dart';
import '../../data/models/transaction_model.dart';

class TransactionList extends StatelessWidget {
  final List<TransactionModel> transactions;

  const TransactionList({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: transactions.length,
      itemBuilder: (_, i) {
        final t = transactions[i];
        return ListTile(
          title: Text(t.title),
          subtitle: Text("${t.amount} - ${t.type.name}"),
          trailing: Text("${t.date.day}/${t.date.month}"),
        );
      },
    );
  }
}
