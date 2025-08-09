import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/followers_provider.dart';

class FollowersPage extends StatelessWidget {
  const FollowersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FollowersProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Followers'),
      ),
      body: provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : provider.followers.isEmpty
              ? const Center(child: Text('Tidak ada followers'))
              : ListView.builder(
                  itemCount: provider.followers.length,
                  itemBuilder: (context, index) {
                    final follower = provider.followers[index];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(follower.avatarUrl),
                      ),
                      title: Text(follower.login),
                    );
                  },
                ),
    );
  }
}
