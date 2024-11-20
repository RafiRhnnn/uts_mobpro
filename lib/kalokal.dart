import 'package:flutter/material.dart';

class KalokalPage extends StatefulWidget {
  const KalokalPage({super.key});

  @override
  State<KalokalPage> createState() => _KalokalPageState();
}

class _KalokalPageState extends State<KalokalPage> {
  TextEditingController searchController = TextEditingController();
  List<String> originList = [
    "343 KA LOKAL Commuter Line Bandung Raya Cicalengka – Padalarang 12.30 – 14.08",
    "345 KA LOKAL Commuter Line Bandung Raya Cicalengka – Padalarang 17.10 – 19.00",
    "347 KA LOKAL Commuter Line Bandung Raya Cicalengka – Padalarang 21.45 – 23.11",
    "351 KA LOKAL Commuter Line Bandung Raya Cicalengka – Padalarang 06.40 – 08.30",
    "353 KA LOKAL Commuter Line Bandung Raya Cicalengka – Padalarang 11.30 – 13.13",
    "355 KA LOKAL Commuter Line Bandung Raya Cicalengka – Padalarang 15.55 – 17.55",
    "357 KA LOKAL Commuter Line Bandung Raya Cicalengka – Padalarang 20.50 – 22.32",
    "361 KA LOKAL Commuter Line Bandung Raya Cicalengka – Padalarang 04.55 – 06.40",
    "363 KA LOKAL Commuter Line Bandung Raya Cicalengka – Padalarang 09.55 – 11.38",
    "365 KA LOKAL Commuter Line Bandung Raya Cicalengka – Padalarang 14.30 – 16.17",
    "367 KA LOKAL Commuter Line Bandung Raya Cicalengka – Padalarang 18.50 – 20.38",
    "369 KA LOKAL Commuter Line Bandung Raya Cicalengka – Kiaracondong 23.20 – 23.47",
    "371 KA LOKAL Commuter Line Bandung Raya Cicalengka – Padalarang 04.20 – 05.59",
    "373 KA LOKAL Commuter Line Bandung Raya Cicalengka – Padalarang 09.20 – 10.55",
    "375 KA LOKAL Commuter Line Bandung Raya Cicalengka – Padalarang 13.20 – 14.58",
    "377 KA LOKAL Commuter Line Bandung Raya Cicalengka – Padalarang 18.05 – 19.50",
    "381 KA LOKAL Commuter Line Bandung Raya Cicalengka – Padalarang 10.45 – 12.23",
    "383 KA LOKAL Commuter Line Bandung Raya Cicalengka – Padalarang 15.05 – 16.49"
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
          content: Text("Tiket untuk $trainInfo seharga Rp 5.000."),
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
        title: const Text('KA Lokal'),
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
