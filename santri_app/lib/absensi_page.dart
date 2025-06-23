import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AbsensiPage extends StatefulWidget {
  final int santriId;
  const AbsensiPage({super.key, required this.santriId});

  @override
  State<AbsensiPage> createState() => _AbsensiPageState();
}

class _AbsensiPageState extends State<AbsensiPage> {
  bool isLoading = true;
  List absensi = [];

  @override
  void initState() {
    super.initState();
    fetchAbsensi();
  }

  Future<void> fetchAbsensi() async {
    try {
      final response = await http.get(Uri.parse(
          'http://10.0.2.2:8000/api/absensi/santri/${widget.santriId}'));

      if (response.statusCode == 200) {
        setState(() {
          absensi = jsonDecode(response.body);
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        print('Gagal mengambil data absensi');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Riwayat Absensi")),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : absensi.isEmpty
              ? Center(child: Text("Belum ada data absensi"))
              : ListView.builder(
                  itemCount: absensi.length,
                  itemBuilder: (context, index) {
                    final item = absensi[index];
                    return ListTile(
                      leading: Icon(
                        item['status'] == 'Hadir'
                            ? Icons.check_circle
                            : Icons.cancel,
                        color: item['status'] == 'Hadir'
                            ? Colors.green
                            : Colors.red,
                      ),
                      title: Text(item['jadwal']['kegiatan']),
                      subtitle: Text(
                          "${item['tanggal']} - ${item['status'].toUpperCase()}"),
                    );
                  },
                ),
    );
  }
}
