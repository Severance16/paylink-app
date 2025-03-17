import 'package:flutter/material.dart';
// import 'package:technical_test/config/constants/enviroment.dart';
import 'package:technical_test/features/shared/shared.dart';

class HomeScreen extends StatelessWidget {
  static const name = 'home';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      drawer: SideMenu( scaffoldKey: scaffoldKey ),
      appBar: AppBar(
        title: const Text('PayLink'),

      ),
      body: const _ContentHomeView(),

    );
  }
}


class _ContentHomeView extends StatelessWidget {
  const _ContentHomeView();

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Wiget de recarga'));
  }
}

