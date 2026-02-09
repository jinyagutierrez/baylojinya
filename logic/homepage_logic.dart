import 'package:flutter/material.dart';

class HomepageLogic {
  final searchController = TextEditingController();

  List<Map<String, dynamic>> nearbyItems = [];

  void dispose() {
    searchController.dispose();
  }

  void loadNearbyItems() {
    // TODO: Load items from API/database
    nearbyItems = [
      {
        'id': '1',
        'title': 'Lorem Ipsum',
        'distance': '2 km',
        'image': null,
        'isFavorite': false,
      },
      {
        'id': '2',
        'title': 'Lorem Ipsum',
        'distance': '3 km',
        'image': null,
        'isFavorite': false,
      },
      {
        'id': '3',
        'title': 'Lorem Ipsum',
        'distance': '1.5 km',
        'image': null,
        'isFavorite': false,
      },
      {
        'id': '4',
        'title': 'Lorem Ipsum',
        'distance': '4 km',
        'image': null,
        'isFavorite': false,
      },
    ];
  }

  Future<void> refreshItems() async {
    // TODO: Implement refresh logic
    await Future.delayed(const Duration(seconds: 1));
    loadNearbyItems();
  }
}
