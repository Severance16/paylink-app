import 'package:flutter/material.dart';
import 'package:technical_test/features/shared/widgets/widgets.dart';

class LoginScreen extends StatelessWidget {
  static const name = 'login';

  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final scaffoldBackgroundColor = Theme.of(context).scaffoldBackgroundColor;

    return Scaffold(
      body: GeometricalBackground(
        child: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 100),
              Icon(
                Icons.developer_mode_rounded,
                color: Color.fromRGBO(238, 238, 238, 1),
                size: 100,
              ),
              
              SizedBox(height: 100),
          
              Container(
                height: size.height - 280,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: scaffoldBackgroundColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(100),
                  ),
                ),
                child: _LoginForm(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm();

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          const SizedBox(height: 60),
          Text('Bienvenido a', style: textStyles.titleSmall),
          Text('PayLink', style: textStyles.titleMedium),
          const SizedBox(height: 70),

          const CustomTextFormField(
            label: 'Correo',
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 30),

          const CustomTextFormField(label: 'Contraseña', obscureText: true),

          const SizedBox(height: 30),

          SizedBox(
            width: double.infinity,
            height: 60,
            child: CustomFilledButton(
              text: 'Ingresar',
              buttonColor: Color.fromRGBO(34, 40, 49, 1),
              onPressed: (){

              },
            )
          ),
          const Spacer(flex: 2),
        ],
      ),
    );
  }
}
