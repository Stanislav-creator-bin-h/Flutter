import 'package:flutter_test/flutter_test.dart';
import 'package:lr14_testing/models/task.dart'; 

void main() {
  group('Task Model (Unit)', () {
    test('Task is created correctly', () {
      final task = Task(id: 1, title: 'Test');
      expect(task.id, 1);
      expect(task.title, 'Test');
      expect(task.isDone, false);
    });

    test('toggle() changes isDone status', () {
      final task = Task(id: 1, title: 'Test');
      task.toggle();
      expect(task.isDone, true);
    });

    test('fromJson creates Task from Map', () {
      final json = {'id': 99, 'title': 'JSON Task', 'isDone': true};
      final task = Task.fromJson(json);
      expect(task.id, 99);
      expect(task.isDone, true);
    });

    test('toJson converts Task to Map', () {
      final task = Task(id: 42, title: 'Map Task', isDone: false);
      final json = task.toJson();
      expect(json['id'], 42);
      expect(json['title'], 'Map Task');
      expect(json['isDone'], false);
    });
  });
}