import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:technical_test/features/auth/presentation/providers/login_form_provider.dart';
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

class _LoginForm extends ConsumerWidget {
  const _LoginForm();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginForm = ref.watch(loginFormProvider);
    final textStyles = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          SizedBox(height: 60),
          Text('Bienvenido a', style: textStyles.titleSmall),
          Text('PayLink', style: textStyles.titleMedium),
          SizedBox(height: 70),

          CustomTextFormField(
            label: 'Usuario',
            keyboardType: TextInputType.text,
            onChanged: ref.read(loginFormProvider.notifier).onUserChange,
            errorMessage:
                loginForm.isFormPosted ? loginForm.user.errorMessage : null,
          ),
          SizedBox(height: 30),

          CustomTextFormField(
            label: 'Contraseña',
            obscureText: true,
            onChanged: ref.read(loginFormProvider.notifier).onPasswordChange,
            errorMessage:
                loginForm.isFormPosted ? loginForm.password.errorMessage : null,
          ),

          SizedBox(height: 30),

          SizedBox(
            width: double.infinity,
            height: 60,
            child: CustomFilledButton(
              text: 'Ingresar',
              buttonColor: Color.fromRGBO(34, 40, 49, 1),
              onPressed: () {
                ref.read(loginFormProvider.notifier).onFormSubmit();
              },
            ),
          ),
          Spacer(flex: 2),
        ],
      ),
    );
  }
}
