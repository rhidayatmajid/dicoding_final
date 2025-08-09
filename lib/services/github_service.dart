import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/follower.dart';
import '../models/profile.dart';

class GitHubService {
  static const String baseUrl = "https://api.github.com";

  static Future<List<Follower>> fetchFollowers(String username) async {
    final response = await http.get(Uri.parse('$baseUrl/users/$username/followers'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Follower.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load followers');
    }
  }

  static Future<Profile> fetchProfile(String username) async {
    final response = await http.get(Uri.parse('$baseUrl/users/$username'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return Profile.fromJson(data);
    } else {
      throw Exception('Failed to load profile');
    }
  }
}
