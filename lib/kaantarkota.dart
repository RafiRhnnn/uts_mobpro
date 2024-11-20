import 'package:flutter/material.dart';

class KaAntarKotaPage extends StatefulWidget {
  const KaAntarKotaPage({super.key});

  @override
  State<KaAntarKotaPage> createState() => _KaAntarKotaPageState();
}

class _KaAntarKotaPageState extends State<KaAntarKotaPage> {
  TextEditingController searchController = TextEditingController();
  List<String> originList = [
    "KA Bengawan (246A) berangkat dari Stasiun Pasar Senen pukul 05.55 WIB",
    "KA Sawunggalih (148A) berangkat dari Stasiun Pasar Senen pukul 07.05 WIB",
    "KA Kutojaya Utara (224A) berangkat dari Stasiun Pasar Senen pukul 08.55 WIB",
    "KA Tawang Jaya Premium (152B) berangkat dari Stasiun Pasar Senen pukul 09.50 WIB",
    "KA Mutiara Selatan (86) relasi Bandung - Surabaya Gubeng",
    "KA Mataram (90) relasi Pasar Senen - Solo Balapan",
    "KA Mataram (89) relasi Solo Balapan - Pasar Senen",
    "KA Bima (60) relasi Gambir - Surabaya Gubeng",
    "Argo Parahyangan berangkat dari Bekasi ke Bandung pukul 05.37 WIB dan tiba pukul 08.39 WIB",
    "Argo Parahyangan Premium berangkat dari Bekasi ke Bandung pukul 09.17 WIB dan tiba pukul 12.01 WIB"
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
