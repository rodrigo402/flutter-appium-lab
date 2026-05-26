import 'package:flutter/material.dart';

import 'package:appium_flutter_demo/app/router/app_routes.dart';
import 'package:appium_flutter_demo/core/constants/app_keys.dart';
import 'package:appium_flutter_demo/core/constants/app_semantics.dart';
import 'package:appium_flutter_demo/core/constants/app_strings.dart';
import 'package:appium_flutter_demo/core/widgets/app_button.dart';
import 'package:appium_flutter_demo/core/widgets/app_scaffold.dart';
import 'package:appium_flutter_demo/core/widgets/app_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String? _errorMessage;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    setState(() => _errorMessage = null);

    if (!_formKey.currentState!.validate()) return;

    final email = _emailController.text.trim();
    final password = _passwordController.text;

    final isValid = email == AppStrings.demoEmail &&
        password == AppStrings.demoPassword;

    if (isValid) {
      Navigator.pushReplacementNamed(context, AppRoutes.home);
      return;
    }

    setState(() => _errorMessage = AppStrings.loginError);
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: AppStrings.loginTitle,
      showBackButton: false,
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppTextField(
              inputKey: AppKeys.loginEmailInput,
              semanticsLabel: AppSemantics.loginEmailInput,
              label: AppStrings.emailLabel,
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Ingresa tu email';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            AppTextField(
              inputKey: AppKeys.loginPasswordInput,
              semanticsLabel: AppSemantics.loginPasswordInput,
              label: AppStrings.passwordLabel,
              controller: _passwordController,
              obscureText: true,
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (_) => _submit(),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Ingresa tu contraseña';
                }
                return null;
              },
            ),
            if (_errorMessage != null) ...[
              const SizedBox(height: 16),
              Semantics(
                label: AppSemantics.loginErrorText,
                container: true,
                child: Text(
                  _errorMessage!,
                  key: AppKeys.loginErrorText,
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
              ),
            ],
            const Spacer(),
            AppButton(
              buttonKey: AppKeys.loginButton,
              semanticsLabel: AppSemantics.loginButton,
              label: AppStrings.loginButton,
              onPressed: _submit,
            ),
          ],
        ),
      ),
    );
  }
}
