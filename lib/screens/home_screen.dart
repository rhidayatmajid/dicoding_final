import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  Map<String, dynamic>? _userData;
  List<dynamic> _followers = [];
  bool _isLoading = false;
  String? _errorMessage;

  Future<void> _fetchUserData(String username) async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      // Ambil data profile
      final userResponse =
          await http.get(Uri.parse('https://api.github.com/users/$username'));

      if (userResponse.statusCode != 200) {
        setState(() {
          _errorMessage = "User tidak ditemukan";
          _isLoading = false;
        });
        return;
      }

      final userData = json.decode(userResponse.body);

      // Ambil data followers (maksimal 6 untuk preview)
      final followersResponse = await http.get(Uri.parse(
          'https://api.github.com/users/$username/followers?per_page=6'));

      final followersData = json.decode(followersResponse.body);

      setState(() {
        _userData = userData;
        _followers = followersData;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = "Terjadi kesalahan: $e";
        _isLoading = false;
      });
    }
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Cari username GitHub...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: const Icon(Icons.search),
              ),
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  _fetchUserData(value);
                }
              },
            ),
          ),
          const SizedBox(width: 8),
          ElevatedButton(
            onPressed: () {
              if (_searchController.text.isNotEmpty) {
                _fetchUserData(_searchController.text);
              }
            },
            child: const Text("Cari"),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileCard() {
    if (_userData == null) {
      return const Center(
        child: Text(
          "Masukkan username untuk melihat profil",
          style: TextStyle(fontSize: 16),
        ),
      );
    }

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(_userData!['avatar_url']),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _userData!['login'] ?? '',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(_userData!['name'] ?? ''),
                  const SizedBox(height: 4),
                  Text(
                    _userData!['bio'] ?? 'Tidak ada bio',
                    style: const TextStyle(fontStyle: FontStyle.italic),
                  ),
                  const SizedBox(height: 4),
                  Text("Followers: ${_userData!['followers']}"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFollowersGrid() {
    if (_followers.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(16),
        child: Text("Tidak ada followers untuk ditampilkan"),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _followers.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // 3 kolom
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, index) {
        final follower = _followers[index];
        return Column(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(follower['avatar_url']),
            ),
            const SizedBox(height: 4),
            Text(
              follower['login'],
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 12),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildSearchBar(),
            if (_isLoading)
              const Center(child: CircularProgressIndicator())
            else if (_errorMessage != null)
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  _errorMessage!,
                  style: const TextStyle(color: Colors.red),
                ),
              )
            else ...[
              _buildProfileCard(),
              const SizedBox(height: 8),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Followers:",
                    style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              _buildFollowersGrid(),
            ],
          ],
        ),
      ),
    );
  }
}
