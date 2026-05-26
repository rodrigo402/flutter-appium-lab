import 'package:flutter/material.dart';

/// Stable keys for widget tests and legacy Flutter Driver locators.
/// Accessibility labels for Appium UiAutomator2 live in [AppSemantics].
abstract final class AppKeys {
  // Login
  static const loginEmailInput = ValueKey<String>('login_email_input');
  static const loginPasswordInput = ValueKey<String>('login_password_input');
  static const loginButton = ValueKey<String>('login_button');
  static const loginErrorText = ValueKey<String>('login_error_text');

  // Home
  static const homeTitle = ValueKey<String>('home_title');
  static const homeItemsButton = ValueKey<String>('home_items_button');

  // Items list
  static const itemsListTitle = ValueKey<String>('items_list_title');
  static const itemCard1 = ValueKey<String>('item_card_1');
  static const itemCard2 = ValueKey<String>('item_card_2');
  static const itemCard3 = ValueKey<String>('item_card_3');

  // Item detail
  static const detailTitle = ValueKey<String>('detail_title');
  static const detailContinueButton = ValueKey<String>('detail_continue_button');

  // Transfer form
  static const formNameInput = ValueKey<String>('form_name_input');
  static const formAmountInput = ValueKey<String>('form_amount_input');
  static const formDescriptionInput = ValueKey<String>('form_description_input');
  static const formSubmitButton = ValueKey<String>('form_submit_button');
  static const formErrorText = ValueKey<String>('form_error_text');

  // Transfer confirmation
  static const confirmationTitle = ValueKey<String>('confirmation_title');
  static const confirmationSummary = ValueKey<String>('confirmation_summary');
  static const confirmationBackHomeButton =
      ValueKey<String>('confirmation_back_home_button');
}
