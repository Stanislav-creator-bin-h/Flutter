import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:lr14_testing/services/api_service.dart';

@GenerateMocks([http.Client])
import 'task_service_test.mocks.dart'; 

void main() {
  group('TaskApiService Mock Tests (Unit)', () {
    late ApiService apiService;
    late MockClient mockClient;

    setUp(() {
      mockClient = MockClient();
      apiService = ApiService(client: mockClient);
    });

    test('fetchTasks returns list on success (200 OK)', () async {
      final jsonResponse = '[{"id": 1, "title": "API Task", "isDone": false}]';
      
      when(mockClient.get(Uri.parse('https://api.example.com/tasks')))
          .thenAnswer((_) async => http.Response(jsonResponse, 200));

      final tasks = await apiService.fetchTasks();
      expect(tasks.length, 1);
      expect(tasks.first.title, 'API Task');
    });

    test('fetchTasks throws Exception on error (404)', () async {
      when(mockClient.get(Uri.parse('https://api.example.com/tasks')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      expect(() => apiService.fetchTasks(), throwsException);
    });
  });
}