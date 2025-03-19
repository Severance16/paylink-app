import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:technical_test/features/auth/presentation/providers/auth_provider.dart';
import 'package:technical_test/features/auth/presentation/screens/screens.dart';
import 'package:technical_test/features/recharge/domain/entities/entities.dart';
import 'package:technical_test/features/recharge/presentation/screens/recharge_detail_screen.dart';
import 'package:technical_test/features/recharge/presentation/screens/recharge_resume_screen.dart';
import 'package:technical_test/features/recharge/presentation/screens/recharge_screen.dart';
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
        path: '/login',
        name: LoginScreen.name,
        builder: (context, state) => LoginScreen(),
      ),
      GoRoute(
        path: '/',
        name: HomeScreen.name,
        builder: (context, state) => HomeScreen(),
      ),
      GoRoute(
        path: '/recharge',
        name: RechargeScreen.name,
        builder: (context, state) => RechargeScreen(),
      ),
      GoRoute(
        path: '/detail',
        name: RechargeDetailScreen.name,
        builder: (context, state) => RechargeDetailScreen(),
      ),
      GoRoute(
        path: '/resume',
        name: RechargeResumeScreen.name,
        builder: (context, state) {
          final ticket = state.extra as Ticket;
          return RechargeResumeScreen(ticket: ticket);
        },
      ),
    ],

    redirect: (context, state) {

      final isGoingTo = state.uri.toString();
      final authStatus = goRouterNotifier.authStatus;

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
