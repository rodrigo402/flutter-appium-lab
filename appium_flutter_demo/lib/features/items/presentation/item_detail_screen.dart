import 'package:flutter/material.dart';

import 'package:appium_flutter_demo/app/router/app_routes.dart';
import 'package:appium_flutter_demo/core/constants/app_keys.dart';
import 'package:appium_flutter_demo/core/constants/app_strings.dart';
import 'package:appium_flutter_demo/core/widgets/app_button.dart';
import 'package:appium_flutter_demo/core/widgets/app_scaffold.dart';
import 'package:appium_flutter_demo/features/items/domain/item_model.dart';

class ItemDetailScreen extends StatelessWidget {
  const ItemDetailScreen({super.key, required this.item});

  final ItemModel item;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppScaffold(
      title: item.title,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            item.title,
            key: AppKeys.detailTitle,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            item.subtitle,
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.colorScheme.primary,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            item.description,
            style: theme.textTheme.bodyLarge,
          ),
          const Spacer(),
          AppButton(
            buttonKey: AppKeys.detailContinueButton,
            label: AppStrings.itemDetailContinue,
            onPressed: () {
              Navigator.pushNamed(
                context,
                AppRoutes.transferForm,
                arguments: item,
              );
            },
          ),
        ],
      ),
    );
  }
}
