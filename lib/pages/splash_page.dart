import 'package:flutter/material.dart';
import 'home_page.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[50],
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Gambar Splash
                Image.network(
                  'https://images.unsplash.com/photo-1600891964599-f61ba0e24092',
                  height: 220,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 24),

                // Judul
                Text(
                  "Selamat Datang di Foodie App",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange[800],
                  ),
                ),
                const SizedBox(height: 12),

                // Deskripsi
                Text(
                  "Temukan makanan favoritmu dari berbagai pilihan lezat.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                  ),
                ),
                const SizedBox(height: 40),

                // Tombol CTA
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange[800],
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      PageRouteBuilder(
                        transitionDuration: const Duration(milliseconds: 800),
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            const HomePage(),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          // Animasi Fade + Slide
                          final slideAnimation = Tween<Offset>(
                                  begin: const Offset(0.2, 0),
                                  end: Offset.zero)
                              .animate(
                                  CurvedAnimation(parent: animation, curve: Curves.easeOut));

                          final fadeAnimation = Tween<double>(
                                  begin: 0, end: 1)
                              .animate(
                                  CurvedAnimation(parent: animation, curve: Curves.easeIn));

                          return SlideTransition(
                            position: slideAnimation,
                            child: FadeTransition(
                              opacity: fadeAnimation,
                              child: child,
                            ),
                          );
                        },
                      ),
                    );
                  },
                  child: const Text(
                    "Mulai Sekarang",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
