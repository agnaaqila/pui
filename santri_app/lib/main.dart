import 'package:flutter/material.dart';
import 'package:santri_app/absensi_page.dart';
import 'login_page.dart';
import 'home_page.dart';
import 'pengumuman_page.dart';

void main() {
  runApp(const SantriApp());
}

class SantriApp extends StatelessWidget {
  const SantriApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Santri Nurussalam',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // theme config ...
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginPage(),
        '/home': (context) {
          final santri = ModalRoute.of(context)!.settings.arguments as Map;
          return HomePage(santri: santri);
        },
        '/pengumuman': (context) => const PengumumanPage(), // <--- INI WAJIB ADA
        '/absensi': (context) => const AbsensiPage(santriId: 1)
      },
    );
  }
}