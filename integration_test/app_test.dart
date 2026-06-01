import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:lr14_testing/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized;

  group('End-to-End Flow', () {
    testWidgets('Повний цикл: додати задачу -> видалити задачу', (tester) async {
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField), 'Integration Test Task');
      await tester.tap(find.text('Add'));
      await tester.pumpAndSettle();

      expect(find.text('Integration Test Task'), findsOneWidget);

      await tester.tap(find.byIcon(Icons.delete_outline).last); 
      await tester.pumpAndSettle();

      expect(find.text('Integration Test Task'), findsNothing);
    });
  });
}