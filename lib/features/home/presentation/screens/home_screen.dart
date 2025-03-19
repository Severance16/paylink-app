import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:technical_test/features/auth/presentation/widgets/home_page_button.dart';
import 'package:technical_test/features/shared/shared.dart';

class HomeScreen extends StatelessWidget {
  static const name = 'home';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    final textStyles = Theme.of(context).textTheme;

    return Scaffold(
      drawer: SideMenu(scaffoldKey: scaffoldKey),
      appBar: AppBar(
        title: Text('Inicio', style: textStyles.titleMedium),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search_rounded)),
        ],
      ),
      body: const _ContentHomeView(),
    );
  }
}

class _ContentHomeView extends StatelessWidget {
  const _ContentHomeView();

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          Center(
            child: Text('Nuestros servicios', style: textStyles.headlineLarge),
          ),
          SizedBox(height: 30),
          Wrap(
            spacing: 15,
            runSpacing: 10,
            children: [
              HomePageButton(
                text: 'Recargas',
                icon: Icons.mobile_friendly_rounded,
                onPressed: () {
                  context.push('/recharge');
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
