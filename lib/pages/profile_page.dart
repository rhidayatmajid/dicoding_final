import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Saya'),
        backgroundColor: Colors.deepOrange,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 60,
              backgroundImage: const AssetImage('assets/images/rhida.png'),
              backgroundColor: Colors.grey[200],
            ),
            const SizedBox(height: 16),
            const Text(
              'Rahmat Hidayat Majid',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text('rahmat@hidayat.com', style: TextStyle(fontSize: 16, color: Colors.grey)),
            const SizedBox(height: 16),
            const Text(
              'Pengembang Flutter pemula',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: const ListTile(
                leading: Icon(Icons.phone, color: Colors.deepOrange),
                title: Text('Nomor Telepon'),
                subtitle: Text('+62 812 3456 7890'),
              ),
            ),
            const SizedBox(height: 10),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: const ListTile(
                leading: Icon(Icons.location_on, color: Colors.deepOrange),
                title: Text('Lokasi'),
                subtitle: Text('Banda Aceh, Indonesia'),
              ),
            ),
            const SizedBox(height: 10),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: const ListTile(
                leading: Icon(Icons.work, color: Colors.deepOrange),
                title: Text('Pekerjaan'),
                subtitle: Text('Flutter Developer'),
              ),
            ),
            // const SizedBox(height: 24),
            // ElevatedButton.icon(
            //   onPressed: () {
            //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Keluar berhasil')));
            //   },
            //   icon: const Icon(Icons.logout),
            //   label: const Text('Keluar'),
            //   style: ElevatedButton.styleFrom(
            //     backgroundColor: Colors.redAccent,
            //     padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
