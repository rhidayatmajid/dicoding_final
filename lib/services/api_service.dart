import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/follower.dart';

class ApiService {
  static const String baseUrl = "https://api.github.com";

  static Future<List<Follower>> fetchFollowers() async {
    final url = Uri.parse('$baseUrl/users/salamidrus/followers');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Follower.fromJson(json)).toList();
    } else {
      throw Exception('Gagal memuat followers');
    }
  }
}
