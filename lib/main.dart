// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:appwrite/appwrite.dart';

import 'core/constants/app_strings.dart';
import 'data/datasources/local_datasource.dart';
import 'data/datasources/remote_datasource.dart';
import 'data/models/transaction_model.dart';
import 'data/repositories/transaction_repository_impl.dart';
import 'presentation/pages/home_page.dart';
import 'presentation/pages/login_page.dart';
import 'domain/repositories/transaction_repository.dart';

// Hive adapter registration
Future<void> initHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TransactionModelAdapter());
  Hive.registerAdapter(TransactionTypeAdapter());
  await Hive.openBox<TransactionModel>('transactions');
}

// Appwrite client & database config
final client = Client()
  ..setEndpoint('https://[YOUR_ENDPOINT].appwrite.io/v1') // Replace
  ..setProject('[YOUR_PROJECT_ID]'); // Replace

final account = Account(client);
final databases = Databases(client);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initHive();

  runApp(ProviderScope(overrides: [
    localDataSourceProvider.overrideWithValue(HiveLocalDataSource(Hive.box('transactions'))),
    remoteDataSourceProvider.overrideWithValue(
      AppwriteRemoteDataSource(
        database: databases,
        databaseId: '[YOUR_DATABASE_ID]', // Replace
        collectionId: '[YOUR_COLLECTION_ID]', // Replace
      ),
    ),
    accountProvider.overrideWithValue(account),
  ], child: const MyApp()));
}

// Providers (global)
final localDataSourceProvider = Provider<LocalDataSource>((ref) => throw UnimplementedError());
final remoteDataSourceProvider = Provider<RemoteDataSource>((ref) => throw UnimplementedError());

final accountProvider = Provider<Account>((ref) => throw UnimplementedError());

final transactionRepositoryProvider = Provider<TransactionRepository>((ref) {
  final local = ref.watch(localDataSourceProvider);
  final remote = ref.watch(remoteDataSourceProvider);
  return TransactionRepositoryImpl(
    localDataSource: local,
    remoteDataSource: remote,
  );
});

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: FutureBuilder(
        future: ref.read(accountProvider).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(body: Center(child: CircularProgressIndicator()));
          } else if (snapshot.hasData) {
            return const HomePage();
          } else {
            return const LoginPage();
          }
        },
      ),
    );
  }
}
