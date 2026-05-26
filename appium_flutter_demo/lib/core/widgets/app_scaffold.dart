import 'package:flutter/material.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({
    super.key,
    this.title,
    required this.body,
    this.showBackButton = true,
  });

  final String? title;
  final Widget body;
  final bool showBackButton;

  @override
  Widget build(BuildContext context) {
    final canPop = Navigator.of(context).canPop();

    return Scaffold(
      appBar: title == null
          ? null
          : AppBar(
              title: Text(title!),
              automaticallyImplyLeading: showBackButton && canPop,
            ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: body,
        ),
      ),
    );
  }
}
