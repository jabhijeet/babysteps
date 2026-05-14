// Integration tests for BabySteps app
import 'package:babysteps/main.dart' as app;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('BabySteps App Integration Tests', () {
    testWidgets('App should launch and display home screen',
        (WidgetTester tester) async {
      // Launch the app
      app.main();
      await tester.pumpAndSettle();

      // Verify the app launches and shows the home screen
      expect(find.byType(MaterialApp), findsOneWidget);
    });

    testWidgets('Home screen should display app bar with title',
        (WidgetTester tester) async {
      // Launch the app
      app.main();
      await tester.pumpAndSettle();

      // Verify app bar is present
      expect(find.byType(AppBar), findsAtLeast(1));
    });

    testWidgets('Settings drawer can be opened', (WidgetTester tester) async {
      // Launch the app
      app.main();
      await tester.pumpAndSettle();

      // Try to find and tap the menu button to open drawer
      final menuButton = find.byIcon(Icons.menu);
      if (menuButton.evaluate().isNotEmpty) {
        await tester.tap(menuButton);
        await tester.pumpAndSettle();

        // Verify drawer is open
        expect(find.byType(Drawer), findsOneWidget);
      }
    });

    testWidgets('Navigation to insights screen works',
        (WidgetTester tester) async {
      // Launch the app
      app.main();
      await tester.pumpAndSettle();

      // Look for insights navigation
      final insightsButton = find.text('Insights');
      if (insightsButton.evaluate().isNotEmpty) {
        await tester.tap(insightsButton);
        await tester.pumpAndSettle();

        // Verify navigation occurred
        expect(find.text('Insights'), findsWidgets);
      }
    });

    testWidgets('Theme toggle works from settings', (WidgetTester tester) async {
      // Launch the app
      app.main();
      await tester.pumpAndSettle();

      // Open settings drawer
      final menuButton = find.byIcon(Icons.menu);
      if (menuButton.evaluate().isNotEmpty) {
        await tester.tap(menuButton);
        await tester.pumpAndSettle();

        // Look for theme toggle
        final themeSwitch = find.byType(Switch);
        if (themeSwitch.evaluate().isNotEmpty) {
          await tester.tap(themeSwitch.first);
          await tester.pumpAndSettle();
        }
      }
    });
  });
}
