import 'package:flutter/material.dart';

class LrtPage extends StatefulWidget {
  const LrtPage({super.key});

  @override
  State<LrtPage> createState() => _LrtPageState();
}

class _LrtPageState extends State<LrtPage> {
  TextEditingController searchController = TextEditingController();
  List<String> originList = [
    "LRT Jakarta berangkat dari Stasiun Velodrome ke Dukuh Atas pukul 06.00 WIB",
    "LRT Jakarta berangkat dari Stasiun Velodrome ke Dukuh Atas pukul 06.15 WIB",
    "LRT Jakarta berangkat dari Stasiun Velodrome ke Dukuh Atas pukul 06.30 WIB",
    "LRT Jakarta berangkat dari Stasiun Velodrome ke Dukuh Atas pukul 06.45 WIB",
    "LRT Jakarta berangkat dari Stasiun Velodrome ke Dukuh Atas pukul 07.00 WIB",
    "LRT Jakarta berangkat dari Stasiun Velodrome ke Dukuh Atas pukul 07.15 WIB",
    "LRT Jakarta berangkat dari Stasiun Velodrome ke Dukuh Atas pukul 07.30 WIB",
    "LRT Jakarta berangkat dari Stasiun Velodrome ke Dukuh Atas pukul 07.45 WIB",
    "LRT Jakarta berangkat dari Stasiun Dukuh Atas ke Velodrome pukul 06.10 WIB",
    "LRT Jakarta berangkat dari Stasiun Dukuh Atas ke Velodrome pukul 06.25 WIB",
    "LRT Jakarta berangkat dari Stasiun Dukuh Atas ke Velodrome pukul 06.40 WIB",
    "LRT Jakarta berangkat dari Stasiun Dukuh Atas ke Velodrome pukul 06.55 WIB",
    "LRT Jakarta berangkat dari Stasiun Dukuh Atas ke Velodrome pukul 07.10 WIB",
    "LRT Jakarta berangkat dari Stasiun Dukuh Atas ke Velodrome pukul 07.25 WIB",
    "LRT Jakarta berangkat dari Stasiun Dukuh Atas ke Velodrome pukul 07.40 WIB",
    "LRT Jakarta berangkat dari Stasiun Dukuh Atas ke Velodrome pukul 07.55 WIB"
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
