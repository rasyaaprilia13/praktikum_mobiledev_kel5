import 'package:flutter/material.dart';

class User {
  final String fullname;
  final String username;
  final String email;
  final String password;

  User({
    required this.fullname,
    required this.username,
    required this.email,
    required this.password,
  });
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final List<User> registeredUsers = [
    User(
      fullname: 'Rasya Aprilia',
      username: 'rasya',
      email: 'rasya@gmail.com',
      password: 'rasya123',
    ),
  ];

  void _login() {
    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();

    User? userFound;
    for (var user in registeredUsers) {
      if (user.username == username && user.password == password) {
        userFound = user;
        break;
      }
    }

    if (userFound != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Login Berhasil! Selamat datang ${userFound.fullname}'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Username atau password salah.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }


  void _register() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Tombol Register ditekan (belum ada halaman)"),
        backgroundColor: Colors.blue,
      ),
    );
  }

  void _lostPassword() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Lost Password ditekan"),
        backgroundColor: Colors.orange,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 80.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/gambarLogin.jpg', width: 100),

              const SizedBox(height: 20),

              // Judul
              const Text(
                'WELCOME BACK!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),

              // Subjudul
              const Text(
                'Sign in to continue',
                style: TextStyle(color: Colors.blue, fontSize: 16),
              ),
              const SizedBox(height: 50),

              // Username
              TextField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  labelText: 'Username',
                  border: UnderlineInputBorder(),
                ),
              ),
              const SizedBox(height: 30),

              // Password
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: UnderlineInputBorder(),
                ),
              ),
              const SizedBox(height: 50),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: _login,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12),
                        ),
                        child: const Text('Login',
                            style: TextStyle(color: Colors.white)),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: _register,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12),
                        ),
                        child: const Text('Register',
                            style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),

                  // Lost Password
                  TextButton(
                    onPressed: _lostPassword,
                    child: const Text(
                      'Lost Password ?',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
