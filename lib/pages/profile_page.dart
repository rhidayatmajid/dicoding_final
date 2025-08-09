import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/profile_provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final provider = context.read<ProfileProvider>();
      provider.fetchProfile('rhidayatmajid'); // ganti dengan username GitHub kamu
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ProfileProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : provider.profile == null
              ? const Center(child: Text('No data'))
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage:
                            NetworkImage(provider.profile!['avatar_url']),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        provider.profile!['name'] ?? '',
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(provider.profile!['bio'] ?? ''),
                      const SizedBox(height: 8),
                      Text('Public Repos: ${provider.profile!['public_repos']}'),
                      Text('Followers: ${provider.profile!['followers']}'),
                      Text('Following: ${provider.profile!['following']}'),
                    ],
                  ),
                ),
    );
  }
}
