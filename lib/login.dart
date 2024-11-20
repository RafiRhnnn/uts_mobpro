import 'package:flutter/material.dart';
import 'dashboard.dart'; // Pastikan import file dashboard.dart sudah benar

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        backgroundColor: Colors.lightBlue, // Warna navbar menjadi biru muda
      ),
      body: Container(
        color: const Color.fromARGB(
            255, 0, 0, 0), // Warna background menjadi biru tua
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Menengahkan kolom
            children: [
              // Menambahkan logo di atas form login
              Image.asset(
                'assets/images/logo.png', // Path file logo
                height: 120, // Atur tinggi logo
                width: 120, // Atur lebar logo
              ),
              const SizedBox(height: 20), // Jarak antara logo dan form
              TextField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  labelText: 'Username',
                  filled: true, // Mengaktifkan pengisian warna pada background
                  fillColor: Colors.white, // Warna kotak input menjadi putih
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  filled: true, // Mengaktifkan pengisian warna pada background
                  fillColor: Colors.white, // Warna kotak input menjadi putih
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Validasi username dan password
                  if (_usernameController.text == 'rafiraihan' &&
                      _passwordController.text == 'admin321') {
                    // Memanggil halaman Dashboard dengan username
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DashboardPage(
                          username: _usernameController.text,
                        ),
                      ),
                    );
                  } else {
                    // Menampilkan pesan error jika login gagal
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Login Gagal'),
                        content: const Text('Username atau Password salah!'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    );
                  }
                },
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
