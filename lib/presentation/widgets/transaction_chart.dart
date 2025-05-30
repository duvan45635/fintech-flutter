import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../data/models/transaction_model.dart';
import '../../core/enum/transaction_type.dart';

class TransactionChart extends StatelessWidget {
  final List<TransactionModel> transactions;

  const TransactionChart({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    double income = transactions.where((t) => t.type == TransactionType.income).fold(0, (sum, t) => sum + t.amount);
    double expense = transactions.where((t) => t.type == TransactionType.expense).fold(0, (sum, t) => sum + t.amount);

    return SizedBox(
      height: 200,
      child: PieChart(
        PieChartData(sections: [
          PieChartSectionData(value: income, color: Colors.green, title: 'Ingresos'),
          PieChartSectionData(value: expense, color: Colors.red, title: 'Gastos'),
        ]),
      ),
    );
  }
}
