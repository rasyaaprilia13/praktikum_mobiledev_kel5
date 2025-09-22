import 'package:flutter/material.dart';
import 'transaksi.dart'; 

class MenuItem {
  final String name;
  final int price;
  int quantity;

  MenuItem({required this.name, required this.price, this.quantity = 0});
}

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  List<MenuItem> foods = [
    MenuItem(name: 'Makanan 1', price: 5000),
    MenuItem(name: 'Makanan 2', price: 5000),
    MenuItem(name: 'Makanan 3', price: 5000),
    MenuItem(name: 'Makanan 4', price: 5000),
    MenuItem(name: 'Makanan 5', price: 5000),
  ];

  List<MenuItem> drinks = [
    MenuItem(name: 'Minuman 1', price: 7000),
    MenuItem(name: 'Minuman 2', price: 7000),
    MenuItem(name: 'Minuman 3', price: 7000),
    MenuItem(name: 'Minuman 4', price: 7000),
    MenuItem(name: 'Minuman 5', price: 7000),
  ];

  List<MenuItem> snacks = [
    MenuItem(name: 'Cemilan 1', price: 10000),
    MenuItem(name: 'Cemilan 2', price: 12000),
    MenuItem(name: 'Cemilan 3', price: 8000),
  ];

  List<MenuItem> desserts = [
    MenuItem(name: 'Dessert 1', price: 15000),
    MenuItem(name: 'Dessert 2', price: 18000),
    MenuItem(name: 'Dessert 3', price: 20000),
  ];

  int _currentPageIndex = 0;

  void _incrementQuantity(MenuItem item) {
    setState(() {
      item.quantity++;
    });
  }

  void _decrementQuantity(MenuItem item) {
    setState(() {
      if (item.quantity > 0) {
        item.quantity--;
      }
    });
  }

  void _resetOrder() {
    setState(() {
      for (var item in foods) {
        item.quantity = 0;
      }
      for (var item in drinks) {
        item.quantity = 0;
      }
      for (var item in snacks) {
        item.quantity = 0;
      }
      for (var item in desserts) {
        item.quantity = 0;
      }
    });
  }

  // Fungsi yang diperbarui dengan logika validasi
  void _processTransaction() {
    bool isAnyItemSelected = foods.any((item) => item.quantity > 0) ||
        drinks.any((item) => item.quantity > 0) ||
        snacks.any((item) => item.quantity > 0) ||
        desserts.any((item) => item.quantity > 0);

    if (isAnyItemSelected) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const TransaksiPage()),
      ).then((_) {
        _resetOrder();
      });
    } else {
      // Menampilkan pesan peringatan jika tidak ada item yang dipilih
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Silakan pilih menu terlebih dahulu.'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  Widget _buildMenuItem(MenuItem item) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 40,
            child: Text(
              '${item.quantity}',
              style: const TextStyle(fontSize: 18, color: Colors.grey),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Text('Rp. ${item.price}', style: const TextStyle(color: Colors.grey)),
              ],
            ),
          ),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.remove_circle_outline, color: Colors.blue),
                onPressed: () => _decrementQuantity(item),
              ),
              IconButton(
                icon: const Icon(Icons.add_circle_outline, color: Colors.blue),
                onPressed: () => _incrementQuantity(item),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<MenuItem> currentMenu;
    String currentTitle;
    if (_currentPageIndex == 0) {
      currentMenu = foods;
      currentTitle = 'Makanan';
    } else if (_currentPageIndex == 1) {
      currentMenu = drinks;
      currentTitle = 'Minuman';
    } else if (_currentPageIndex == 2) {
      currentMenu = snacks;
      currentTitle = 'Cemilan';
    } else {
      currentMenu = desserts;
      currentTitle = 'Dessert';
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('MENUS', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(currentTitle, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
                ...currentMenu.map((item) => _buildMenuItem(item)).toList(),
              ],
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: _currentPageIndex > 0 ? () => setState(() => _currentPageIndex--) : null,
                  child: Text('← Previous', style: TextStyle(color: _currentPageIndex > 0 ? Colors.blue : Colors.grey)),
                ),
                Row(
                  children: [
                    _buildPageNumber(0),
                    _buildPageNumber(1),
                    _buildPageNumber(2),
                    _buildPageNumber(3),
                  ],
                ),
                TextButton(
                  onPressed: _currentPageIndex < 3 ? () => setState(() => _currentPageIndex++) : null,
                  child: Text('Next →', style: TextStyle(color: _currentPageIndex < 3 ? Colors.blue : Colors.grey)),
                ),
              ],
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: _processTransaction,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  ),
                  child: const Text('Transaction', style: TextStyle(color: Colors.white)),
                ),
                ElevatedButton(
                  onPressed: _resetOrder,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  ),
                  child: const Text('Reset', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPageNumber(int pageIndex) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            _currentPageIndex = pageIndex;
          });
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: _currentPageIndex == pageIndex ? Colors.blue : Colors.grey[300],
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(12),
        ),
        child: Text('${pageIndex + 1}', style: TextStyle(color: _currentPageIndex == pageIndex ? Colors.white : Colors.black)),
      ),
    );
  }
}