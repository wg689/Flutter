import 'package:flutter/material.dart';
import 'package:flutter_bili_app/navigator/hi_navigator.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_bili_app/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets("Test login jump", (WidgetTester tester) async {
    app.main();
    var registrationBtn = find.byKey(Key('registration'));
    await tester.tap(registrationBtn);
    await tester.pumpAndSettle();
    await Future.delayed(Duration(seconds: 3));

    expect(
        HiNavigator.getInstance().getCurrent().routeStatus, RouteStatus.login);
  });
}
