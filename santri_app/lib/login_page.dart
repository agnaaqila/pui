import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _nisController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool isLoading = false;
  String error = '';

  Future<void> login() async {
    setState(() {
      isLoading = true;
      error = '';
    });

    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2:8000/api/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': _nisController.text,
          'password': _passwordController.text,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['santri'] != null) {
        Navigator.pushReplacementNamed(
          context,
          '/home',
          arguments: data['santri'],
        );
      } else {
        setState(() {
          error = data['message'] ?? 'Login gagal';
        });
      }
    } catch (e) {
      print('Catch error: $e');
      setState(() {
        error = 'Terjadi kesalahan koneksi';
      });
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text("Login Santri",
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                SizedBox(height: 20),
                TextField(
                  controller: _nisController,
                  decoration: InputDecoration(
                    labelText: 'NIS',
                    prefixIcon: Icon(Icons.badge),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: Icon(Icons.lock),
                  ),
                ),
                if (error.isNotEmpty) ...[
                  SizedBox(height: 12),
                  Text(error, style: TextStyle(color: Colors.red)),
                ],
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: isLoading ? null : login,
                  child:
                      isLoading ? CircularProgressIndicator() : Text('Login'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
