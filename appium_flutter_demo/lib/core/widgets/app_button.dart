import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    this.buttonKey,
    this.semanticsLabel,
    required this.label,
    required this.onPressed,
    this.isExpanded = true,
  });

  final Key? buttonKey;
  final String? semanticsLabel;
  final String label;
  final VoidCallback? onPressed;
  final bool isExpanded;

  @override
  Widget build(BuildContext context) {
    final button = FilledButton(
      key: buttonKey,
      onPressed: onPressed,
      child: Text(label),
    );

    final sizedButton = isExpanded
        ? SizedBox(width: double.infinity, child: button)
        : button;

    if (semanticsLabel == null) return sizedButton;

    return Semantics(
      label: semanticsLabel,
      button: true,
      onTap: onPressed,
      child: ExcludeSemantics(child: sizedButton),
    );
  }
}
