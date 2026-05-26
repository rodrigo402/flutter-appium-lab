import 'package:flutter/material.dart';

import 'package:appium_flutter_demo/app/router/app_routes.dart';
import 'package:appium_flutter_demo/core/constants/app_keys.dart';
import 'package:appium_flutter_demo/core/constants/app_semantics.dart';
import 'package:appium_flutter_demo/core/constants/app_strings.dart';
import 'package:appium_flutter_demo/core/widgets/app_scaffold.dart';
import 'package:appium_flutter_demo/features/items/data/mock_items.dart';
import 'package:appium_flutter_demo/features/items/presentation/widgets/item_card.dart';

class ItemsListScreen extends StatelessWidget {
  const ItemsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: AppStrings.itemsListTitle,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Semantics(
            label: AppSemantics.itemsListTitle,
            container: true,
            child: ExcludeSemantics(
              child: Text(
                AppStrings.itemsListTitle,
                key: AppKeys.itemsListTitle,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.separated(
              itemCount: mockItems.length,
              separatorBuilder: (context, _) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final item = mockItems[index];

                return Semantics(
                  label: itemCardSemantics[index],
                  button: true,
                  child: KeyedSubtree(
                    key: itemCardKeys[index],
                    child: ItemCard(
                      item: item,
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          AppRoutes.itemDetail,
                          arguments: item,
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
