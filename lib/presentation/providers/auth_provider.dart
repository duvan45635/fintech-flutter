import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:appwrite/models.dart' as models;
import 'package:hive/hive.dart';
import '../../config/providers/global_providers.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final account = ref.read(accountProvider);
  return AuthNotifier(account);
});

class AuthState {
  final bool isLoading;
  final models.Session? session;
  final String? error;

  const AuthState({
    this.isLoading = false,
    this.session,
    this.error,
  });

  AuthState copyWith({
    bool? isLoading,
    models.Session? session,
    String? error,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      session: session ?? this.session,
      error: error,
    );
  }
}

class AuthNotifier extends StateNotifier<AuthState> {
  final dynamic account;

  AuthNotifier(this.account) : super(const AuthState()) {
    _loadSession();
  }

  Future<void> _loadSession() async {
    final userBox = Hive.box('user');
    final storedSession = userBox.get('session');
    if (storedSession != null) {
      state = state.copyWith(session: models.Session.fromMap(storedSession));
    }
  }

  Future<void> login(String email, String password) async {
    try {
      state = state.copyWith(isLoading: true);
      final session = await account.createEmailSession(email: email, password: password);
      final userBox = Hive.box('user');
      userBox.put('session', session.toMap());

      state = state.copyWith(isLoading: false, session: session, error: null);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> register(String email, String password) async {
    try {
      state = state.copyWith(isLoading: true);
      await account.create(userId: ID.unique(), email: email, password: password);
      await login(email, password);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> logout() async {
    try {
      await account.deleteSessions();
      Hive.box('user').delete('session');
      state = const AuthState();
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }
}
  