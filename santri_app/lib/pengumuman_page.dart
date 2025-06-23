import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PengumumanPage extends StatefulWidget {
  const PengumumanPage({super.key});

  @override
  State<PengumumanPage> createState() => _PengumumanPageState();
}

class _PengumumanPageState extends State<PengumumanPage> {
  List pengumuman = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchPengumuman();
  }

  Future<void> fetchPengumuman() async {
    try {
      final response = await http.get(
        Uri.parse('http://10.0.2.2:8000/api/pengumuman'),
      );

      if (response.statusCode == 200) {
        setState(() {
          pengumuman = jsonDecode(response.body);
          isLoading = false;
        });
      } else {
        throw Exception('Gagal mengambil data');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error fetch: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pengumuman"),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : pengumuman.isEmpty
              ? Center(child: Text("Belum ada pengumuman."))
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: pengumuman.length,
                  itemBuilder: (context, index) {
                    final item = pengumuman[index];
                    return Card(
                      margin: EdgeInsets.only(bottom: 12),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      child: ListTile(
                        leading: Icon(Icons.campaign, color: Color(0xFF2980B9)),
                        title: Text(item['judul'],
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text(item['isi']),
                      ),
                    );
                  },
                ),
    );
  }
}
