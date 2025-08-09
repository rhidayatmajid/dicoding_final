import 'package:flutter/material.dart';
import '../models/follower.dart';
import '../services/api_service.dart';

class FollowersProvider with ChangeNotifier {
  List<Follower> _followers = [];
  bool _isLoading = false;

  List<Follower> get followers => _followers;
  bool get isLoading => _isLoading;

  Future<void> getFollowers() async {
    _isLoading = true;
    notifyListeners();

    try {
      _followers = await ApiService.fetchFollowers();
    } catch (e) {
      print("Error: $e");
    }

    _isLoading = false;
    notifyListeners();
  }
}
