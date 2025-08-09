import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(
                "https://avatars.githubusercontent.com/u/1?v=4",
              ),
            ),
            SizedBox(height: 20),
            Text("Nama: John Doe", style: TextStyle(fontSize: 18)),
            Text("Email: johndoe@example.com", style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text("Bio: Flutter Developer", style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
