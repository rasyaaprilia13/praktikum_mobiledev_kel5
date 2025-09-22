

import 'package:flutter/material.dart';

class MenusPage extends StatefulWidget {
  const MenusPage({super.key});

  @override
  State<MenusPage> createState() => _MenusPageState();
}

class _MenusPageState extends State<MenusPage> {

  final List<Map<String, dynamic>> menuItems = [
    {'name': 'Makanan 1', 'price': 5000, 'category': 'Makanan'},
    {'name': 'Makanan 2', 'price': 5000, 'category': 'Makanan'},
    {'name': 'Makanan 3', 'price': 5000, 'category': 'Makanan'},
    {'name': 'Makanan 4', 'price': 5000, 'category': 'Makanan'},
    {'name': 'Makanan 5', 'price': 5000, 'category': 'Makanan'},
    {'name': 'Minuman 1', 'price': 7000, 'category': 'Minuman'},
    {'name': 'Minuman 2', 'price': 7000, 'category': 'Minuman'},
    {'name': 'Minuman 3', 'price': 7000, 'category': 'Minuman'},
    {'name': 'Minuman 4', 'price': 7000, 'category': 'Minuman'},
    {'name': 'Minuman 5', 'price': 7000, 'category': 'Minuman'},
    {'name': 'Snack 1', 'price': 8000, 'category': 'Snack'},
    {'name': 'Snack 2', 'price': 8000, 'category': 'Snack'},
    {'name': 'Snack 3', 'price': 8000, 'category': 'Snack'},
    {'name': 'Snack 4', 'price': 8000, 'category': 'Snack'},
    {'name': 'Snack 5', 'price': 8000, 'category': 'Snack'},
  ];

  
  late List<int> _itemQuantities;
  

  int _currentPage = 0;
  final int _itemsPerPage = 5;

  @override
  void initState() {
    super.initState();
    _itemQuantities = List<int>.filled(menuItems.length, 0);
  }

  void _incrementQuantity(int index) {
    setState(() {
      _itemQuantities[index]++;
    });
  }

  void _decrementQuantity(int index) {
    setState(() {
      if (_itemQuantities[index] > 0) {
        _itemQuantities[index]--;
      }
    });
  }

  void _resetQuantities() {
    setState(() {
      _itemQuantities = List<int>.filled(menuItems.length, 0);
    });
  }

  void _goToPreviousPage() {
    setState(() {
      if (_currentPage > 0) {
        _currentPage--;
      }
    });
  }

  void _goToNextPage() {
    setState(() {
      final int totalPages = (menuItems.length / _itemsPerPage).ceil();
      if (_currentPage < totalPages - 1) {
        _currentPage++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final int totalPages = (menuItems.length / _itemsPerPage).ceil();
    final int startIndex = _currentPage * _itemsPerPage;
    final int endIndex = startIndex + _itemsPerPage > menuItems.length
        ? menuItems.length
        : startIndex + _itemsPerPage;
    
    final List<Map<String, dynamic>> displayedItems = menuItems.sublist(startIndex, endIndex);

    return Scaffold(
      appBar: AppBar(
        title: const Text('MENUS'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildMenuList(displayedItems),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: _currentPage > 0 ? _goToPreviousPage : null,
                  child: const Row(
                    children: [
                      Icon(Icons.arrow_back),
                      Text('Previous'),
                    ],
                  ),
                ),
                const SizedBox(width: 20),
                Text(
                  '${_currentPage + 1}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const Text(' ... '),
                Text(
                  '$totalPages',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 20),
                TextButton(
                  onPressed: _currentPage < totalPages - 1 ? _goToNextPage : null,
                  child: const Row(
                    children: [
                      Text('Next'),
                      Icon(Icons.arrow_forward),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  ),
                  child: const Text('Transaction', style: TextStyle(color: Colors.white)),
                ),
                ElevatedButton(
                  onPressed: _resetQuantities,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  ),
                  child: const Text('Reset', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuList(List<Map<String, dynamic>> items) {
    final Map<String, List<Map<String, dynamic>>> groupedItems = {};
    for (var item in items) {
      final category = item['category'];
      if (!groupedItems.containsKey(category)) {
        groupedItems[category] = [];
      }
      groupedItems[category]?.add(item);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: groupedItems.entries.map((entry) {
        final category = entry.key;
        final categoryItems = entry.value;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              category,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            ...categoryItems.map((item) {
              final int globalIndex = menuItems.indexWhere((element) => element == item);
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    SizedBox(
                      width: 30,
                      child: Text(
                        '${_itemQuantities[globalIndex]}',
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      child: Text(item['name'], style: const TextStyle(fontSize: 16)),
                    ),
                    Text(
                      'Rp. ${item['price']}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(width: 20),
                    _buildQuantityButtons(globalIndex),
                  ],
                ),
              );
            }).toList(),
            const SizedBox(height: 20),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildQuantityButtons(int index) {
    return Row(
      children: [
        SizedBox(
          width: 30,
          height: 30,
          child: ElevatedButton(
            onPressed: () => _decrementQuantity(index),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.zero,
              shape: const CircleBorder(),
            ),
            child: const Icon(Icons.remove, size: 16),
          ),
        ),
        const SizedBox(width: 10),
        SizedBox(
          width: 30,
          height: 30,
          child: ElevatedButton(
            onPressed: () => _incrementQuantity(index),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.zero,
              shape: const CircleBorder(),
            ),
            child: const Icon(Icons.add, size: 16),
          ),
        ),
      ],
    );
  }
}