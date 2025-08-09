import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/follower.dart';

class FollowersProvider with ChangeNotifier {
  List<Follower> _followers = [];
  bool _isLoading = false;

  List<Follower> get followers => _followers;
  bool get isLoading => _isLoading;

  Future<void> fetchFollowers(String username) async {
    _isLoading = true;
    notifyListeners();

    final url = Uri.parse('https://api.github.com/users/$username/followers');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        _followers = data.map((json) => Follower.fromJson(json)).toList();
      } else {
        _followers = [];
      }
    } catch (e) {
      _followers = [];
    }

    _isLoading = false;
    notifyListeners();
  }
}
