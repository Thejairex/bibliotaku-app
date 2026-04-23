import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/auth_repository.dart';

// Estado posible de la sesión
enum AuthStatus { unknown, authenticated, unauthenticated }

class AuthNotifier extends AsyncNotifier<AuthStatus> {

  // Método que construye el estado inicial de la sesión
  @override
  Future<AuthStatus> build() async {
    final repo = ref.read(authRepositoryProvider);
    final hasSession = await repo.hasSession();
    return hasSession ? AuthStatus.authenticated : AuthStatus.unauthenticated;
  }

  // Método que inicia sesión
  Future<void> login({required String email, required String password}) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref.read(authRepositoryProvider).login(
            email: email,
            password: password,
          );
      return AuthStatus.authenticated;
    });
  }

  // Método que cierra sesión
  Future<void> logout() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref.read(authRepositoryProvider).logout();
      return AuthStatus.unauthenticated;
    });
  }
}

// Provider que expone el AuthNotifier
final authProvider = AsyncNotifierProvider<AuthNotifier, AuthStatus>(
  AuthNotifier.new,
);