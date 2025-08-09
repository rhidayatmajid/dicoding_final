import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProfileProvider extends ChangeNotifier {
  Map<String, dynamic>? profile;
  bool isLoading = false;

  Future<void> fetchProfile(String username) async {
    isLoading = true;
    notifyListeners();

    final url = Uri.parse('https://api.github.com/users/$username');
    final res = await http.get(url);

    if (res.statusCode == 200) {
      profile = json.decode(res.body);
    } else {
      profile = null;
    }

    isLoading = false;
    notifyListeners();
  }
}
