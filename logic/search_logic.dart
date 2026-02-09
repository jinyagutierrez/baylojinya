import 'package:flutter/material.dart';

class SearchLogic {
  final searchController = TextEditingController();

  final List<String> categories = [
    'All',
    'Books',
    'Clothes',
    'Electronics',
    'Sports',
  ];

  String selectedCategory = 'All';
  List<Map<String, dynamic>> searchResults = [];

  void dispose() {
    searchController.dispose();
  }

  void selectCategory(String category) {
    selectedCategory = category;
    performSearch(searchController.text);
  }

  void performSearch(String query) {
    // TODO: Implement actual search logic with API
    searchResults = List.generate(
      6,
      (index) => {
        'id': index.toString(),
        'title': 'Item $index',
        'category': categories[index % categories.length],
        'image': null,
      },
    );

    // Filter by category if not "All"
    if (selectedCategory != 'All') {
      searchResults = searchResults
          .where((item) => item['category'] == selectedCategory)
          .toList();
    }
  }
}
