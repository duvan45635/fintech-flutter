// lib/config/providers/global_providers.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:appwrite/appwrite.dart';
import '../appwrite/appwrite_config.dart';

// Cliente Appwrite (podría compartirse en otras capas)
final appwriteClientProvider = Provider<Client>((ref) {
  return AppwriteConfig.client;
});

// Proveedor de cuenta
final accountProvider = Provider<Account>((ref) {
  return AppwriteConfig.account;
});

// Proveedor de base de datos
final databaseProvider = Provider<Databases>((ref) {
  return AppwriteConfig.databases;
});
