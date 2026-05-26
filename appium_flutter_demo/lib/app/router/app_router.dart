import 'package:flutter/material.dart';

import 'package:appium_flutter_demo/app/router/app_routes.dart';
import 'package:appium_flutter_demo/features/auth/presentation/login_screen.dart';
import 'package:appium_flutter_demo/features/home/presentation/home_screen.dart';
import 'package:appium_flutter_demo/features/items/domain/item_model.dart';
import 'package:appium_flutter_demo/features/items/presentation/item_detail_screen.dart';
import 'package:appium_flutter_demo/features/items/presentation/items_list_screen.dart';
import 'package:appium_flutter_demo/features/transfer/domain/transfer_data.dart';
import 'package:appium_flutter_demo/features/transfer/presentation/transfer_confirmation_screen.dart';
import 'package:appium_flutter_demo/features/transfer/presentation/transfer_form_screen.dart';

abstract final class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.login:
        return _page(const LoginScreen(), settings);
      case AppRoutes.home:
        return _page(const HomeScreen(), settings);
      case AppRoutes.itemsList:
        return _page(const ItemsListScreen(), settings);
      case AppRoutes.itemDetail:
        final item = settings.arguments! as ItemModel;
        return _page(ItemDetailScreen(item: item), settings);
      case AppRoutes.transferForm:
        final item = settings.arguments! as ItemModel;
        return _page(TransferFormScreen(item: item), settings);
      case AppRoutes.transferConfirmation:
        final transfer = settings.arguments! as TransferData;
        return _page(
          TransferConfirmationScreen(transfer: transfer),
          settings,
        );
      default:
        return _page(const LoginScreen(), settings);
    }
  }

  static MaterialPageRoute<T> _page<T>(Widget child, RouteSettings settings) {
    return MaterialPageRoute<T>(
      settings: settings,
      builder: (_) => child,
    );
  }
}
