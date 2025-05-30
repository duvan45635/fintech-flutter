// lib/domain/entities/transaction.dart
enum TransactionType { income, expense }

class TransactionEntity {
  final String id;
  final String title;
  final double amount;
  final TransactionType type;
  final DateTime date;

  TransactionEntity({
    required this.id,
    required this.title,
    required this.amount,
    required this.type,
    required this.date,
  });
}
