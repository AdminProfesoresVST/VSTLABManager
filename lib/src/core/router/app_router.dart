import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/auth/presentation/providers/auth_providers.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/register_screen.dart';
import '../../features/dashboard/presentation/screens/dashboard_screen.dart';
import '../../features/assets/presentation/screens/asset_creation_screen.dart';
import '../../features/assets/presentation/screens/qr_generation_screen.dart';
import '../../features/assets/presentation/screens/qr_scanner_screen.dart';
import '../../features/loans/presentation/screens/loan_creation_screen.dart';
import '../../features/loans/presentation/screens/active_loans_screen.dart';
import '../../features/assets/domain/entities/asset.dart';



/// Provider para el router de la aplicación
final appRouterProvider = Provider<GoRouter>((ref) {
  // Crear una instancia temporal para acceder al router
  // El redirect se manejará internamente
  return GoRouter(
    initialLocation: '/login',
    redirect: (context, state) {
      final authState = ref.read(authNotifierProvider);
      final isAuthenticated = authState.isAuthenticated;
      final isLoading = authState.isLoading;
      
      if (isLoading) return null;
      
      final isAuthRoute = state.uri.path == '/login' || state.uri.path == '/register';
      
      if (!isAuthenticated && !isAuthRoute) {
        return '/login';
      }
      
      if (isAuthenticated && isAuthRoute) {
        return '/dashboard';
      }
      
      return null;
    },
    routes: [
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        name: 'register',
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: '/dashboard',
        name: 'dashboard',
        builder: (context, state) => const DashboardScreen(),
      ),
      GoRoute(
        path: '/assets/create',
        name: 'asset-create',
        builder: (context, state) => const AssetCreationScreen(),
      ),
      GoRoute(
        path: '/assets/qr-generate',
        name: 'qr-generate',
        builder: (context, state) {
          final asset = state.extra as Asset?;
          if (asset == null) {
            return const Scaffold(
              body: Center(
                child: Text('Error: Activo no encontrado'),
              ),
            );
          }
          return QrGenerationScreen(asset: asset);
        },
      ),
      GoRoute(
        path: '/qr-scanner',
        name: 'qr-scanner',
        builder: (context, state) => const QrScannerScreen(),
      ),
      GoRoute(
        path: '/loans/create',
        name: 'loan-create',
        builder: (context, state) => const LoanCreationScreen(),
      ),
      GoRoute(
        path: '/loans/active',
        name: 'active-loans',
        builder: (context, state) => const ActiveLoansScreen(),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      appBar: AppBar(
        title: const Text('Error'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.red,
            ),
            const SizedBox(height: 16),
            Text(
              'Página no encontrada',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              'La ruta "${state.uri}" no existe.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => context.go('/dashboard'),
              child: const Text('Ir al Dashboard'),
            ),
          ],
        ),
      ),
    ),
  );
});