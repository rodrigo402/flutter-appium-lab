import 'package:flutter_test/flutter_test.dart';

import 'package:appium_flutter_demo/app/app.dart';
import 'package:appium_flutter_demo/core/constants/app_keys.dart';
import 'package:appium_flutter_demo/core/constants/app_strings.dart';

void main() {
  testWidgets('shows login screen on launch', (WidgetTester tester) async {
    await tester.pumpWidget(const AppiumFlutterDemoApp());
    await tester.pumpAndSettle();

    expect(find.text(AppStrings.loginTitle), findsOneWidget);
    expect(find.byKey(AppKeys.loginEmailInput), findsOneWidget);
    expect(find.byKey(AppKeys.loginPasswordInput), findsOneWidget);
    expect(find.byKey(AppKeys.loginButton), findsOneWidget);
  });
}
