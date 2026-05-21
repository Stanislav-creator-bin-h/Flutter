import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user.dart';

class ApiService {
  static const String baseUrl = 'https://jsonplaceholder.typicode.com';

  // Static cache for users list to preserve data in memory
  static List<User>? _cachedUsers;

  Future<List<User>> getUsers({bool forceRefresh = false}) async {
    if (!forceRefresh && _cachedUsers != null && _cachedUsers!.isNotEmpty) {
      return _cachedUsers!;
    }

    try {
      final response = await http.get(Uri.parse('$baseUrl/users'));
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        _cachedUsers = jsonData.map((json) => User.fromJson(json)).toList();
        return _cachedUsers!;
      } else {
        throw Exception('Failed to load users. Status: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching users: $e');
    }
  }
}