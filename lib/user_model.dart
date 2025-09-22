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

// Variabel global untuk menyimpan data pengguna yang terdaftar sementara.
List<User> registeredUsers = [
  User(
    fullname: 'Rasya Aprilia',
    username: 'rasya',
    email: 'rasya@gmail.com',
    password: 'rasya123',
  ),
];