import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart'; // Tambahkan package ini

// Import halaman baru (akan Anda buat)
import 'kalokal.dart';
import 'kaantarkota.dart';
import 'commuterline.dart';
import 'lrt.dart';
import 'bandara.dart';
import 'whosh.dart';

class DashboardPage extends StatefulWidget {
  final String username;

  const DashboardPage({super.key, required this.username});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final TextEditingController _searchController = TextEditingController();
  final List<Map<String, String>> _allDestinations = [
    {'name': 'Bandung', 'image': 'bandung.jpg'},
    {'name': 'Jakarta', 'image': 'jakarta.jpg'},
    {'name': 'Surabaya', 'image': 'surabaya.jpg'},
    {'name': 'Yogyakarta', 'image': 'yogyakarta.jpg'},
    {'name': 'Semarang', 'image': 'semarang.jpg'},
    {'name': 'Malang', 'image': 'malang.jpg'},
    {'name': 'Solo', 'image': 'solo.jpg'},
    {'name': 'Purwakarta', 'image': 'purwakarta.jpg'},
    {'name': 'Tasik', 'image': 'tasik.jpg'},
    {'name': 'Garut', 'image': 'garut.jpg'},
    {'name': 'Bekasi', 'image': 'bekasi.jpg'},
    {'name': 'Depok', 'image': 'depok.jpg'},
    {'name': 'Bogor', 'image': 'bogor.jpg'},
  ];
  List<Map<String, String>> _filteredDestinations = [];
  int _currentIndex = 0; // Untuk menyimpan indeks halaman aktif

  @override
  void initState() {
    super.initState();
    _filteredDestinations = List.from(_allDestinations);

    _searchController.addListener(() {
      setState(() {
        _filteredDestinations = _allDestinations
            .where((destination) => destination['name']!
                .toLowerCase()
                .contains(_searchController.text.toLowerCase()))
            .toList();
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      _buildHomePage(),
      _buildProfilePage(),
    ];

    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: const Color.fromARGB(
            255, 255, 0, 0), // Warna latar belakang halaman
        color: Colors.blue, // Warna Curved Navigation Bar
        items: const [
          Icon(Icons.home, size: 30, color: Colors.white), // Ikon Home
          Icon(Icons.person, size: 30, color: Colors.white), // Ikon Profile
        ],
        onTap: (index) {
          setState(() {
            _currentIndex =
                index; // Perbarui indeks berdasarkan tab yang ditekan
          });
        },
      ),
    );
  }

  Widget _buildHomePage() {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Selamat datang, ${widget.username}'),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.shopping_cart),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.message),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.help_outline),
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Cari tujuan...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildTrainTypeCard(context, 'KA Lokal', const KalokalPage()),
                  _buildTrainTypeCard(
                      context, 'KA Antar Kota', const KaAntarKotaPage()),
                  _buildTrainTypeCard(
                      context, 'Commuter Line', const CommuterLinePage()),
                  _buildTrainTypeCard(context, 'LRT', const LrtPage()),
                  _buildTrainTypeCard(context, 'Bandara', const BandaraPage()),
                  _buildTrainTypeCard(context, 'Whosh', const WhoshPage()),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final destination = _filteredDestinations[index];
                  return _buildPopularDestinationCard(
                    destination['name']!,
                    destination['image']!,
                  );
                },
                childCount: _filteredDestinations.length,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfilePage() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage:
                  AssetImage('assets/images/saya.jpg'), // Gambar profil
            ),
            const SizedBox(height: 16),
            Text(
              'Username: ${widget.username}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Email: Rafirhn17@gmail.com',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTrainTypeCard(
      BuildContext context, String trainType, Widget page) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
      child: Container(
        width: 100,
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 47, 0, 255),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 25,
              backgroundColor: Colors.blueAccent,
              child: Icon(Icons.train, color: Colors.white),
            ),
            const SizedBox(height: 8),
            Text(
              trainType,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPopularDestinationCard(String destination, String imageName) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
              child: Image.asset(
                'assets/images/$imageName',
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              destination,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
