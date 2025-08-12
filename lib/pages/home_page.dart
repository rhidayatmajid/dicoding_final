import 'package:flutter/material.dart';

import 'detail_page.dart';
import 'profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final Set<int> _favorites = <int>{};

  final List<Map<String, String>> foods = [
    {
      "name": "Nasi Goreng",
      "price": "Rp 20.000",
      "image":
          "https://images.unsplash.com/photo-1647093953000-9065ed6f85ef?auto=format&fit=crop&w=800&q=80",
    },
    {
      "name": "Mie Goreng",
      "price": "Rp 15.000",
      "image":
          "https://images.unsplash.com/photo-1680675494363-75bbf9838a09?auto=format&fit=crop&w=800&q=80",
    },
    {
      "name": "Sate Ayam",
      "price": "Rp 25.000",
      "image":
          "https://images.unsplash.com/photo-1645696301019-35adcc18fc21?auto=format&fit=crop&w=800&q=80",
    },
    {
      "name": "Bakso",
      "price": "Rp 18.000",
      "image":
          "https://images.unsplash.com/photo-1687425973269-af0d62587769?auto=format&fit=crop&w=800&q=80",
    },
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildHomeGrid() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: GridView.builder(
        itemCount: foods.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          // childAspectRatio mengatur perbandingan lebar:tinggi dari KESELURUHAN KARTU.
          // Nilai sekitar 0.7 - 0.8 biasanya baik.
          childAspectRatio: 0.75,
        ),
        itemBuilder: (context, index) {
          final food = foods[index];
          final isFav = _favorites.contains(index);

          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) =>
                      DetailPage(name: food['name']!, price: food['price']!, image: food['image']!),
                ),
              );
            },
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              elevation: 4,
              clipBehavior: Clip.antiAlias,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // --- PERBAIKAN FINAL ---
                  // Area gambar kini fleksibel dan akan mengisi sisa ruang di kartu.
                  Expanded(
                    child: Stack(
                      // Mengatur agar konten (tombol favorit) bisa keluar dari batas Stack
                      // jika perlu, meskipun di sini tidak akan terjadi.
                      clipBehavior: Clip.none,
                      fit: StackFit.expand, // Memastikan Stack mengisi semua area Expanded
                      children: [
                        // AspectRatio dihapus.
                        // ClipRRect langsung menjadi anak dari Stack.
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
                          child: Image.network(
                            food['image']!,
                            // Properti ini memastikan gambar mengisi area yang tersedia
                            // dengan tetap menjaga rasio aspeknya (mungkin terpotong sedikit).
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => Container(
                              color: Colors.grey[200],
                              child: const Center(child: Icon(Icons.broken_image, size: 36)),
                            ),
                          ),
                        ),

                        // Tombol favorit tidak berubah.
                        Positioned(
                          top: 8,
                          right: 8,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                if (isFav) {
                                  _favorites.remove(index);
                                } else {
                                  _favorites.add(index);
                                }
                              });
                            },
                            child: AnimatedScale(
                              scale: isFav ? 1.18 : 1.0,
                              duration: const Duration(milliseconds: 180),
                              curve: Curves.easeOutBack,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.85),
                                  shape: BoxShape.circle,
                                ),
                                padding: const EdgeInsets.all(6),
                                child: Icon(
                                  isFav ? Icons.favorite : Icons.favorite_border,
                                  color: isFav ? Colors.red : Colors.grey[700],
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Area teks tidak diubah, akan menempati ruang yang dibutuhkan di bawah gambar.
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
                    child: Text(
                      food['name']!,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                    child: Text(
                      food['price']!,
                      style: const TextStyle(
                        color: Colors.deepOrange,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pages = [_buildHomeGrid(), const ProfilePage()];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Katalog Makanan'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 246, 176, 85),
      ),
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.deepOrange,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
