import 'package:flutter/material.dart';
import 'global_header.dart';
import 'ui/homepage_screen.dart';
import 'ui/search_screen.dart';
import 'ui/barter_posting_screen.dart';
import 'ui/notification_screen.dart';
import 'ui/profile_screen.dart';
import 'ui/my_account_screen.dart';
import 'ui/inbox_screen.dart';
import 'ui/saved_items_screen.dart';
import 'ui/recently_viewed_screen.dart';
import 'ui/cart_screen.dart';
import 'ui/sell_screen.dart';
import 'ui/settings_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  // Indices of screens that should NOT show the bottom navbar
  final List<int> _screensWithoutNavBar = [5, 6, 7, 8, 9, 10, 11];
  // These correspond to: MyAccountScreen, InboxScreen, SavedItemsScreen,
  // RecentlyViewedScreen, CartScreen, SellScreen, SettingsScreen

  void _onNavItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  bool _shouldShowBottomNav() {
    return !_screensWithoutNavBar.contains(_currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _screens = [
      const HomepageScreen(),
      const SearchScreen(),
      const BarterPostingScreen(),
      const NotificationScreen(),
      ProfileScreen(onNavigate: _onNavItemTapped), // Pass navigation callback
      MyAccountScreen(onNavigate: _onNavItemTapped),
      InboxScreen(onNavigate: _onNavItemTapped),
      SavedItemsScreen(onNavigate: _onNavItemTapped),
      RecentlyViewedScreen(onNavigate: _onNavItemTapped),
      CartScreen(onNavigate: _onNavItemTapped),
      SellScreen(onNavigate: _onNavItemTapped),
      SettingsScreen(onNavigate: _onNavItemTapped),
    ];

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // GLOBAL HEADER (now from separate file)
            const GlobalHeader(),

            // SCREEN CONTENT
            Expanded(
              child: IndexedStack(
                index: _currentIndex,
                children: _screens,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _shouldShowBottomNav() ? _buildBottomNavBar() : null,
    );
  }

  Widget _buildBottomNavBar() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        height: 70,
        decoration: BoxDecoration(
          color: const Color(0xFF6B4423),
          borderRadius: BorderRadius.circular(35),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildNavItem(Icons.home_outlined, 0),
                _buildNavItem(Icons.search, 1),
                const SizedBox(width: 60),
                _buildNavItem(Icons.notifications_outlined, 3),
                _buildNavItem(Icons.person_outline, 4),
              ],
            ),
            Positioned(
              top: -15,
              left: 0,
              right: 0,
              child: Center(
                child: _buildNavItemCenter(Icons.add, 2),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, int index) {
    return SizedBox(
      height: 70,
      child: Center(
        child: IconButton(
          icon: Icon(icon, size: 30),
          color: Colors.white,
          onPressed: () => _onNavItemTapped(index),
        ),
      ),
    );
  }

  Widget _buildNavItemCenter(IconData icon, int index) {
    return GestureDetector(
      onTap: () => _onNavItemTapped(index),
      child: Container(
        width: 70,
        height: 70,
        decoration: BoxDecoration(
          color: const Color(0xFFD9E8F5),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Icon(
          icon,
          size: 40,
          color: const Color(0xFF6B4423),
        ),
      ),
    );
  }
}
