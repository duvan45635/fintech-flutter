// lib/core/enums/transaction_type.dart
enum TransactionType {
  income,
  expense;

  String get name {
    switch (this) {
      case TransactionType.income:
        return 'Ingreso';
      case TransactionType.expense:
        return 'Gasto';
    }
  }
}
