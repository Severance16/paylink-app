import 'package:go_router/go_router.dart';
import 'package:technical_test/presentation/screens/screens.dart';

final appRouter = GoRouter(
  routes: [
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
);
