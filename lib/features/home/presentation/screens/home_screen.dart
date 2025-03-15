import 'package:flutter/material.dart';
import 'package:technical_test/config/constants/enviroment.dart';

class HomeScreen extends StatelessWidget {
  static const name = 'home';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(Enviroment.apiUrl),
      ),
    );
  }
}

