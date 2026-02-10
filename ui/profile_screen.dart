import 'package:flutter/material.dart';
import 'inbox_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD9E8F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFFD9E8F5),
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.3),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(
            Icons.arrow_forward_ios,
            color: Color(0xFF8F5032),
            size: 20,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                // Profile Card with User Info
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      // Profile Picture
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color(0xFF8F5032),
                            width: 2,
                          ),
                        ),
                        child: const CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.person,
                            size: 30,
                            color: Color(0xFF8F5032),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      // User Info
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Juan Dela Cruz',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF2C1810),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '48 1st 2d St, Moonwalk Subdivision Barangay 880 Brgy, Las Pinas city, Metro Manila',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                                height: 1.3,
                              ),
                              maxLines: 3,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Menu Container
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      _buildMenuItem(
                        icon: Icons.person_outline,
                        title: 'MY ACCOUNT',
                        onTap: () {},
                      ),
                      _buildDivider(),
                      _buildMenuItem(
                        icon: Icons.chat_bubble_outline,
                        title: 'INBOX',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const InboxScreen(),
                            ),
                          );
                        },
                      ),
                      _buildDivider(),
                      _buildMenuItem(
                        icon: Icons.favorite_border,
                        title: 'SAVED ITEMS',
                        onTap: () {},
                      ),
                      _buildDivider(),
                      _buildMenuItem(
                        icon: Icons.remove_red_eye_outlined,
                        title: 'RECENTLY VIEWED',
                        onTap: () {},
                      ),
                      _buildDivider(),
                      _buildMenuItem(
                        icon: Icons.shopping_cart_outlined,
                        title: 'CART',
                        onTap: () {},
                      ),
                      _buildDivider(),
                      _buildMenuItem(
                        icon: Icons.storefront_outlined,
                        title: 'SELL',
                        onTap: () {},
                      ),
                      _buildDivider(),
                      _buildMenuItem(
                        icon: Icons.settings_outlined,
                        title: 'SETTINGS',
                        onTap: () {},
                      ),
                      _buildDivider(),
                      _buildMenuItem(
                        icon: Icons.logout,
                        title: 'LOGOUT',
                        onTap: () {
                          // Show logout confirmation
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Logout'),
                              content: const Text('Are you sure you want to logout?'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    // Add logout logic here
                                  },
                                  child: const Text(
                                    'Logout',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          children: [
            Icon(
              icon,
              color: const Color(0xFF2C1810),
              size: 24,
            ),
            const SizedBox(width: 16),
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF2C1810),
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Divider(
        height: 1,
        color: Colors.grey[300],
      ),
    );
  }
}
