import 'package:flutter/material.dart';
import 'ui/homepage_screen.dart';         // ← Add ui/ prefix
import 'ui/search_screen.dart';           // ← Add ui/ prefix
import 'ui/barter_posting_screen.dart';   // ← Add ui/ prefix
import 'ui/inbox_screen.dart';            // ← Add ui/ prefix
import 'ui/profile_screen.dart';          // ← Add ui/ prefix

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
     HomepageScreen(),      // ← Keep as HomepageScreen (not HomepageContent)
     SearchScreen(),
     BarterPostingScreen(),
     InboxScreen(),
     ProfileScreen(),
  ];

  void _onNavItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildBottomNavBar() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF8F5032),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(Icons.home, 0),
              _buildNavItem(Icons.search, 1),
              _buildNavItemCenter(Icons.add, 2),
              _buildNavItem(Icons.notifications, 3),
              _buildNavItem(Icons.person, 4),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, int index) {
    final isSelected = _currentIndex == index;
    return GestureDetector(
      onTap: () => _onNavItemTapped(index),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFFFF9C4) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          icon,
          color: isSelected ? const Color(0xFF2C1810) : Colors.white,
          size: 24,
        ),
      ),
    );
  }

  Widget _buildNavItemCenter(IconData icon, int index) {
    return GestureDetector(
      onTap: () => _onNavItemTapped(index),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Color(0xFFFFF9C4),
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: const Color(0xFF2C1810),
          size: 28,
        ),
      ),
    );
  }
}
