import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

import 'package:lr14_testing/models/task.dart';
import 'package:lr14_testing/utils/validators.dart';
import 'package:lr14_testing/services/api_service.dart';

@GenerateMocks([http.Client])
import 'unit_test.mocks.dart'; 

void main() {
  group('1. Task Model Tests (Unit)', () {
    test('1. Task is created correctly', () {
      final task = Task(id: 1, title: 'Test');
      expect(task.id, 1);
      expect(task.title, 'Test');
    });

    test('2. toggle() changes isDone status', () {
      final task = Task(id: 1, title: 'Test');
      task.toggle();
      expect(task.isDone, true);
    });

    test('3. fromJson creates Task from Map', () {
      final json = {'id': 99, 'title': 'JSON Task', 'isDone': true};
      final task = Task.fromJson(json);
      expect(task.id, 99);
      expect(task.isDone, true);
    });

    test('4. toJson converts Task to Map', () {
      final task = Task(id: 42, title: 'Map Task', isDone: false);
      final json = task.toJson();
      expect(json['id'], 42);
      expect(json['title'], 'Map Task');
    });
  });

  group('2. Validation Tests (Unit)', () {
    test('5. validateTitle returns null for valid text', () {
      expect(Validators.validateTitle('Good title'), isNull);
    });

    test('6. validateTitle returns error for empty text', () {
      expect(Validators.validateTitle(''), 'Title cannot be empty');
    });

    test('7. validateTitle returns error for null', () {
      expect(Validators.validateTitle(null), 'Title cannot be empty');
    });
    
    test('8. validateTitle returns error for spaces only', () {
      expect(Validators.validateTitle('   '), 'Title cannot be empty');
    });
  });

  group('3. API Service Mock Tests (Unit)', () {
    late ApiService apiService;
    late MockClient mockClient;

    setUp(() {
      mockClient = MockClient();
      apiService = ApiService(client: mockClient);
    });

    test('9. fetchTasks returns list on success (200 OK)', () async {
      final jsonResponse = '[{"id": 1, "title": "API Task", "isDone": false}]';
      
      when(mockClient.get(Uri.parse('https://api.example.com/tasks')))
          .thenAnswer((_) async => http.Response(jsonResponse, 200));

      final tasks = await apiService.fetchTasks();
      expect(tasks.length, 1);
      expect(tasks.first.title, 'API Task');
    });

    test('10. fetchTasks throws Exception on error (404)', () async {
      when(mockClient.get(Uri.parse('https://api.example.com/tasks')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      expect(() => apiService.fetchTasks(), throwsException);
    });
  });
}