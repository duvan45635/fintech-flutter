import 'package:appwrite/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:appwrite/models.dart';
import '../../main.dart';

final authViewModelProvider = StateNotifierProvider<AuthViewModel, bool>((ref) {
  final account = ref.read(accountProvider);
  return AuthViewModel(account);
});

class AuthViewModel extends StateNotifier<bool> {
  final Account account;
  AuthViewModel(this.account) : super(false);

  Future<bool> login(String email, String password) async {
    try {
      await account.createEmailSession(email: email, password: password);
      state = true;
      return true;
    } catch (_) {
      state = false;
      return false;
    }
  }

  Future<void> register(String email, String password) async {
    await account.create(userId: ID.unique(), email: email, password: password);
  }
}
