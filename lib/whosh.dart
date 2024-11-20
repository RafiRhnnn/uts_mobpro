import 'package:flutter/material.dart';

class WhoshPage extends StatefulWidget {
  const WhoshPage({super.key});

  @override
  State<WhoshPage> createState() => _WhoshPageState();
}

class _WhoshPageState extends State<WhoshPage> {
  TextEditingController searchController = TextEditingController();
  List<String> originList = [
    "Kereta Cepat WHOOSH berangkat dari Stasiun TegalLuar ke Halim pukul 05.30 WIB",
    "Kereta Cepat WHOOSH berangkat dari Stasiun TegalLuar ke Halim pukul 06.30 WIB",
    "Kereta Cepat WHOOSH berangkat dari Stasiun TegalLuar ke Halim pukul 07.30 WIB",
    "Kereta Cepat WHOOSH berangkat dari Stasiun TegalLuar ke Halim pukul 08.30 WIB",
    "Kereta Cepat WHOOSH berangkat dari Stasiun TegalLuar ke Halim pukul 09.30 WIB",
    "Kereta Cepat WHOOSH berangkat dari Stasiun TegalLuar ke Halim pukul 10.30 WIB",
    "Kereta Cepat WHOOSH berangkat dari Stasiun TegalLuar ke Halim pukul 11.30 WIB",
    "Kereta Cepat WHOOSH berangkat dari Stasiun TegalLuar ke Halim pukul 12.30 WIB",
    "Kereta Cepat WHOOSH berangkat dari Stasiun Halim ke TegalLuar pukul 05.45 WIB",
    "Kereta Cepat WHOOSH berangkat dari Stasiun Halim ke TegalLuar pukul 06.45 WIB",
    "Kereta Cepat WHOOSH berangkat dari Stasiun Halim ke TegalLuar pukul 07.45 WIB",
    "Kereta Cepat WHOOSH berangkat dari Stasiun Halim ke TegalLuar pukul 08.45 WIB",
    "Kereta Cepat WHOOSH berangkat dari Stasiun Halim ke TegalLuar pukul 09.45 WIB",
    "Kereta Cepat WHOOSH berangkat dari Stasiun Halim ke TegalLuar pukul 10.45 WIB",
    "Kereta Cepat WHOOSH berangkat dari Stasiun Halim ke TegalLuar pukul 11.45 WIB",
    "Kereta Cepat WHOOSH berangkat dari Stasiun Halim ke TegalLuar pukul 12.45 WIB"
  ];
  late List<String> filteredList;
  String keyword = '';

  @override
  void initState() {
    super.initState();
    originList.sort();
    filteredList = List.from(originList);
  }

  void showTicketPrice(String trainInfo) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Harga Tiket"),
          content: Text("Tiket untuk $trainInfo seharga Rp 100.000."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
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
        title: const Text('KA Antar Kota'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: const InputDecoration(
                labelText: 'Search',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                setState(() {
                  keyword = value.toLowerCase();
                  filteredList = originList
                      .where((item) => item.toLowerCase().contains(keyword))
                      .toList();
                });
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const Icon(Icons.train_outlined, size: 40),
                  title: Text(filteredList[index]),
                  onTap: () {
                    showTicketPrice(filteredList[index]);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
