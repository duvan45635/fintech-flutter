// lib/data/datasources/remote_datasource.dart
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;
import '../../core/exceptions/failure.dart';
import '../models/transaction_model.dart';
import '../../core/enum/transaction_type.dart';

abstract class RemoteDataSource {
  Future<void> addTransaction(TransactionModel transaction);
  Future<List<TransactionModel>> getTransactions();
  Future<void> deleteTransaction(String id);
}

class AppwriteRemoteDataSource implements RemoteDataSource {
  final Databases database;
  final String databaseId;
  final String collectionId;

  AppwriteRemoteDataSource({
    required this.database,
    required this.databaseId,
    required this.collectionId,
  });

  @override
  Future<void> addTransaction(TransactionModel transaction) async {
    try {
      await database.createDocument(
        databaseId: databaseId,
        collectionId: collectionId,
        documentId: transaction.hiveId,
        data: {
          'title': transaction.title,
          'amount': transaction.amount,
          'type': transaction.type.name,
          'date': transaction.date.toIso8601String(),
        },
      );
    } catch (e) {
      throw Failure('Error al crear transacción remota: $e');
    }
  }

  @override
  Future<List<TransactionModel>> getTransactions() async {
    try {
      final result = await database.listDocuments(
        databaseId: databaseId,
        collectionId: collectionId,
      );

      return result.documents.map((doc) {
        return TransactionModel(
          hiveId: doc.$id,
          title: doc.data['title'],
          amount: (doc.data['amount'] as num).toDouble(),
          type: doc.data['type'] == 'income' ? TransactionType.income : TransactionType.expense,
          date: DateTime.parse(doc.data['date']),
        );
      }).toList();
    } catch (e) {
      throw Failure('Error al obtener transacciones remotas: $e');
    }
  }

  @override
  Future<void> deleteTransaction(String id) async {
    try {
      await database.deleteDocument(
        databaseId: databaseId,
        collectionId: collectionId,
        documentId: id,
      );
    } catch (e) {
      throw Failure('Error al eliminar transacción remota: $e');
    }
  }
}
