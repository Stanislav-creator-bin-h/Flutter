import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/task.dart';

class ApiService {
  final http.Client client;

  ApiService({required this.client});

  Future<List<Task>> fetchTasks() async {
    final response = await client.get(Uri.parse('https://api.example.com/tasks'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Task.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load tasks');
    }
  }
}