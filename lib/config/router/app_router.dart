import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:technical_test/features/auth/presentation/providers/auth_provider.dart';
import 'package:technical_test/features/auth/presentation/screens/screens.dart';
import 'package:technical_test/features/home/presentation/screens/screens.dart';
import 'app_router_notifier.dart';

final goRouterProvider = Provider((ref) {

  final goRouterNotifier = ref.read(goRouterNotifierProvider);
  
  return GoRouter(
    initialLocation: '/splash',
    refreshListenable: goRouterNotifier,
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => CheckAuthStatusScreen(),
      ),
      GoRoute(
        path: '/',
        name: HomeScreen.name,
        builder: (context, state) => HomeScreen(),
      ),
      GoRoute(
        path: '/login',
        name: LoginScreen.name,
        builder: (context, state) => LoginScreen(),
      ),
    ],

    redirect: (context, state) {

      final isGoingTo = state.uri.toString();
      final authStatus = goRouterNotifier.authStatus;

      print(isGoingTo);
      print(authStatus);
      
      if (isGoingTo == '/splash' && authStatus == AuthStatus.checking) return null;
      if (authStatus == AuthStatus.noAutenticated) {
        if (isGoingTo == "/login") return null;
        return '/login';
      }

      if (authStatus == AuthStatus.authenticated) {
        if (isGoingTo == '/login' || isGoingTo == '/splash') return '/';
      }
      
      return null;
    },
  );
});
