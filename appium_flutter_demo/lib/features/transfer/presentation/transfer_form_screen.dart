import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:appium_flutter_demo/app/router/app_routes.dart';
import 'package:appium_flutter_demo/core/constants/app_keys.dart';
import 'package:appium_flutter_demo/core/constants/app_strings.dart';
import 'package:appium_flutter_demo/core/widgets/app_button.dart';
import 'package:appium_flutter_demo/core/widgets/app_scaffold.dart';
import 'package:appium_flutter_demo/core/widgets/app_text_field.dart';
import 'package:appium_flutter_demo/features/items/domain/item_model.dart';
import 'package:appium_flutter_demo/features/transfer/domain/transfer_data.dart';

class TransferFormScreen extends StatefulWidget {
  const TransferFormScreen({super.key, required this.item});

  final ItemModel item;

  @override
  State<TransferFormScreen> createState() => _TransferFormScreenState();
}

class _TransferFormScreenState extends State<TransferFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();

  String? _errorMessage;

  @override
  void dispose() {
    _nameController.dispose();
    _amountController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _submit() {
    setState(() => _errorMessage = null);

    if (!_formKey.currentState!.validate()) return;

    final amount = double.tryParse(_amountController.text.replaceAll(',', '.'));

    if (amount == null || amount <= 0) {
      setState(() => _errorMessage = AppStrings.formAmountRequired);
      return;
    }

    final transfer = TransferData(
      recipientName: _nameController.text.trim(),
      amount: amount,
      description: _descriptionController.text.trim().isEmpty
          ? null
          : _descriptionController.text.trim(),
    );

    Navigator.pushNamed(
      context,
      AppRoutes.transferConfirmation,
      arguments: transfer,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: AppStrings.transferFormTitle,
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppTextField(
              inputKey: AppKeys.formNameInput,
              label: AppStrings.nameLabel,
              controller: _nameController,
              textInputAction: TextInputAction.next,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return AppStrings.formNameRequired;
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            AppTextField(
              inputKey: AppKeys.formAmountInput,
              label: AppStrings.amountLabel,
              controller: _amountController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              textInputAction: TextInputAction.next,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d*[.,]?\d{0,2}')),
              ],
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return AppStrings.formAmountRequired;
                }
                final amount =
                    double.tryParse(value.replaceAll(',', '.'));
                if (amount == null || amount <= 0) {
                  return AppStrings.formAmountRequired;
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            AppTextField(
              inputKey: AppKeys.formDescriptionInput,
              label: AppStrings.descriptionLabel,
              controller: _descriptionController,
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (_) => _submit(),
            ),
            if (_errorMessage != null) ...[
              const SizedBox(height: 16),
              Text(
                _errorMessage!,
                key: AppKeys.formErrorText,
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            ],
            const Spacer(),
            AppButton(
              buttonKey: AppKeys.formSubmitButton,
              label: AppStrings.confirmButton,
              onPressed: _submit,
            ),
          ],
        ),
      ),
    );
  }
}
