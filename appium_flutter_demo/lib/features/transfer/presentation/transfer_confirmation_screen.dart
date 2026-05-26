import 'package:flutter/material.dart';

import 'package:appium_flutter_demo/app/router/app_routes.dart';
import 'package:appium_flutter_demo/core/constants/app_keys.dart';
import 'package:appium_flutter_demo/core/constants/app_semantics.dart';
import 'package:appium_flutter_demo/core/constants/app_strings.dart';
import 'package:appium_flutter_demo/core/widgets/app_button.dart';
import 'package:appium_flutter_demo/core/widgets/app_scaffold.dart';
import 'package:appium_flutter_demo/features/transfer/domain/transfer_data.dart';

class TransferConfirmationScreen extends StatelessWidget {
  const TransferConfirmationScreen({super.key, required this.transfer});

  final TransferData transfer;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppScaffold(
      showBackButton: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Icon(
            Icons.check_circle_outline,
            size: 72,
            color: theme.colorScheme.primary,
          ),
          const SizedBox(height: 24),
          Semantics(
            label: AppSemantics.confirmationTitle,
            container: true,
            child: ExcludeSemantics(
              child: Text(
                AppStrings.confirmationTitle,
                key: AppKeys.confirmationTitle,
                textAlign: TextAlign.center,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            AppStrings.confirmationMessage,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyLarge,
          ),
          const SizedBox(height: 32),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Semantics(
              label: AppSemantics.confirmationSummary,
              value: transfer.summary,
              container: true,
              child: ExcludeSemantics(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      transfer.summary,
                      key: AppKeys.confirmationSummary,
                      style: theme.textTheme.bodyLarge,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const Spacer(),
          AppButton(
            buttonKey: AppKeys.confirmationBackHomeButton,
            semanticsLabel: AppSemantics.confirmationBackHomeButton,
            label: AppStrings.backHomeButton,
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.home,
                (_) => false,
              );
            },
          ),
        ],
      ),
    );
  }
}
