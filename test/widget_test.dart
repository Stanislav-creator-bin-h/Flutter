import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:lr14_testing/main.dart'; 

void main() {
  group('Widget Tests for TaskListScreen', () {
    
    testWidgets('1. TaskListWidget відображає початковий список', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      expect(find.text('Buy groceries'), findsOneWidget);
      expect(find.text('Do homework'), findsOneWidget);
      expect(find.text('1 of 4 tasks completed'), findsOneWidget);
    });

    testWidgets('2. Checkbox toggle працює і оновлює статистику', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      await tester.tap(find.byType(Checkbox).first);
      await tester.pump();

      expect(find.text('2 of 4 tasks completed'), findsOneWidget);
    });

    testWidgets('3. Form валідація та додавання задачі', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField), 'New Widget Task');
      await tester.tap(find.text('Add'));
      await tester.pumpAndSettle();

      expect(find.text('New Widget Task'), findsOneWidget);
      expect(find.text('1 of 5 tasks completed'), findsOneWidget);
    });

    testWidgets('4. Кнопка Delete видаляє задачу', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      expect(find.text('Buy groceries'), findsOneWidget);

      await tester.tap(find.byIcon(Icons.delete_outline).first);
      await tester.pumpAndSettle();

      expect(find.text('Buy groceries'), findsNothing);
      expect(find.text('Task removed'), findsOneWidget);
    });

    testWidgets('5. EmptyState показується коли список порожній', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      for (int i = 0; i < 4; i++) {
        await tester.tap(find.byIcon(Icons.delete_outline).first);
        await tester.pumpAndSettle();
      }

      expect(find.text('No tasks yet!'), findsOneWidget);
      expect(find.byIcon(Icons.checklist_rounded), findsOneWidget);
    });
  });
}