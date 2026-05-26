import 'package:flutter/material.dart';

import 'package:appium_flutter_demo/app/router/app_routes.dart';
import 'package:appium_flutter_demo/core/constants/app_keys.dart';
import 'package:appium_flutter_demo/core/constants/app_semantics.dart';
import 'package:appium_flutter_demo/core/constants/app_strings.dart';
import 'package:appium_flutter_demo/core/widgets/app_button.dart';
import 'package:appium_flutter_demo/core/widgets/app_scaffold.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppScaffold(
      showBackButton: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Semantics(
            label: AppSemantics.homeTitle,
            container: true,
            child: ExcludeSemantics(
              child: Text(
                AppStrings.homeWelcome,
                key: AppKeys.homeTitle,
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.homeDemoCardTitle,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    AppStrings.homeDemoCardBody,
                    style: theme.textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ),
          const Spacer(),
          AppButton(
            buttonKey: AppKeys.homeItemsButton,
            semanticsLabel: AppSemantics.homeItemsButton,
            label: AppStrings.homeItemsButton,
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.itemsList);
            },
          ),
        ],
      ),
    );
  }
}
