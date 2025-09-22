// lib/register_page.dart
import 'package:flutter/material.dart';
import 'user_model.dart';
import 'login.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _fullnameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  void _register() {
    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password dan Confirm Password tidak cocok.')),
      );
      return;
    }

    registeredUsers.add(
      User(
        fullname: _fullnameController.text,
        username: _usernameController.text,
        email: _emailController.text,
        password: _passwordController.text,
      ),
    );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
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
              Image.asset('asset/shop.jpg', width: 100),
              const SizedBox(height: 20),
              const Text(
                'Create Account',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              const Text(
                'Join us today!',
                style: TextStyle(color: Colors.blue, fontSize: 16),
              ),
              const SizedBox(height: 50),
              TextField(controller: _fullnameController, decoration: const InputDecoration(labelText: 'Fullname', border: UnderlineInputBorder())),
              const SizedBox(height: 30),
              TextField(controller: _usernameController, decoration: const InputDecoration(labelText: 'Username', border: UnderlineInputBorder())),
              const SizedBox(height: 30),
              TextField(controller: _emailController, decoration: const InputDecoration(labelText: 'Email', border: UnderlineInputBorder())),
              const SizedBox(height: 30),
              TextField(controller: _passwordController, decoration: const InputDecoration(labelText: 'Password',), obscureText: true,),
              const SizedBox(height: 30),
              TextField(controller: _confirmPasswordController, decoration: const InputDecoration(labelText: 'Confirm Password'), obscureText: true,),
              const SizedBox(height: 50),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _register,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
                    ),
                    child: const Text('Register', style: TextStyle(color: Colors.white)),
                  ),
                  const SizedBox(width: 10),
                  
                  // --- Perubahan pada bagian teks "Sign In" ---
                  Expanded(
                    child: Row(
                      children: [
                        const Text(
                          'Already have an account? ',
                          style: TextStyle(color: Colors.grey),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginPage()));
                          },
                          child: const Text(
                            'Sign In',
                            style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
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