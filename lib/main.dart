import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:technical_test/config/router/app_router.dart';
import 'package:technical_test/config/theme/app_theme.dart';

void main() {
  runApp(ProviderScope(child: const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      theme: AppTheme().getTheme(),
    );
  }
}
