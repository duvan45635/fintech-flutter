// lib/data/models/transaction_model.dart
import 'package:hive/hive.dart';
import '../../domain/entities/transaction.dart';

part 'transaction_model.g.dart';

@HiveType(typeId: 0)
class TransactionModel extends TransactionEntity {
  @HiveField(0)
  final String hiveId;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final double amount;

  @HiveField(3)
  final TransactionType type;

  @HiveField(4)
  final DateTime date;

  TransactionModel({
    required this.hiveId,
    required this.title,
    required this.amount,
    required this.type,
    required this.date,
  }) : super(
          id: hiveId,
          title: title,
          amount: amount,
          type: type,
          date: date,
        );

  factory TransactionModel.fromEntity(TransactionEntity entity) {
    return TransactionModel(
      hiveId: entity.id,
      title: entity.title,
      amount: entity.amount,
      type: entity.type,
      date: entity.date,
    );
  }

  TransactionEntity toEntity() => TransactionEntity(
        id: hiveId,
        title: title,
        amount: amount,
        type: type,
        date: date,
      );
}
