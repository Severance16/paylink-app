import 'package:go_router/go_router.dart';
import 'package:technical_test/features/auth/presentation/screens/screens.dart';
import 'package:technical_test/features/home/presentation/screens/screens.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/asd',
      builder: (context, state) => CheckAuthStatusScreen(),
    ),
    GoRoute(
      path: '/home',
      name: HomeScreen.name,
      builder: (context, state) => HomeScreen(),
    ),
    GoRoute(
      path: '/',
      name: LoginScreen.name,
      builder: (context, state) => LoginScreen(),
    ),
  ],
);
