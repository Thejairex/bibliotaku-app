import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:bibliotaku_app/features/home/presentation/screens/home_screen.dart';
import 'routes.dart';

// Aquí se define el router principal de la aplicación
final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    // Aquí se define la ruta inicial de la aplicación
    initialLocation: AppRoutes.home,
    // Aquí se definen las rutas de la aplicación
    routes: [
      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) => const HomeScreen(),
      ),
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
