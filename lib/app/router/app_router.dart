import 'package:bibliotaku_app/features/auth/domain/providers/auth_provider.dart';
import 'package:bibliotaku_app/features/auth/presentation/screens/login_screen.dart';
import 'package:bibliotaku_app/features/library/presentation/screens/library_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:bibliotaku_app/features/home/presentation/screens/home_screen.dart';
import 'routes.dart';

// Aquí se define el router principal de la aplicación
final appRouterProvider = Provider<GoRouter>((ref) {
  // Se define el router principal de la aplicación
  final authState = ref.watch(authProvider);
  return GoRouter(
    // Aquí se define la ruta inicial de la aplicación
    initialLocation: AppRoutes.home,
    redirect: (context, state) {
      final isLoading = authState.isLoading;
      final isAuth = authState.value == AuthStatus.authenticated;
      final onLogin = state.matchedLocation == AppRoutes.login;

      if (isLoading) return null;
      if (!isAuth && !onLogin) return AppRoutes.login;
      if (isAuth && onLogin) return AppRoutes.home;
      return null;
    },
    // Aquí se definen las rutas de la aplicación
    routes: [
      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.library,
        builder: (context, state) => const LibraryScreen(),
      ), // Ruta: '/library'
      // GoRoute(
      //   path: AppRoutes.profile,
      //   builder: (context, state) => const ProfileScreen(), // Ruta: '/profile'
      // ),
      // GoRoute(
      //   path: AppRoutes.auth,
      //   builder: (context, state) => const AuthScreen(),
      // ),
    ],
  );
});
