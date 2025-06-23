import 'package:flutter/material.dart';
import 'package:santri_app/absensi_page.dart';

class HomePage extends StatelessWidget {
  final Map santri;

  const HomePage({super.key, required this.santri});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: Color(0xFF2C3E50),
        title: Text(
          'Santri Nurussalam',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              color: Colors.white,
              elevation: 4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: ListTile(
                leading: Icon(Icons.person, color: Color(0xFF2980B9)),
                title: Text(santri['nama'],
                    style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle:
                    Text('NIS: ${santri['nis']} \nKelas: ${santri['kelas']}'),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF2980B9),
                minimumSize: Size(double.infinity, 50),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/pengumuman');
              },
              icon: Icon(Icons.campaign),
              label: Text('Lihat Pengumuman'),
            ),
            SizedBox(height: 10),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF2980B9),
                minimumSize: Size(double.infinity, 50),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AbsensiPage(santriId: santri['id']),
                  ),
                );
              },
              icon: Icon(Icons.check_circle_outline),
              label: Text('Lihat Absensi'),
            ),
          ],
        ),
      ),
    );
  }
}
