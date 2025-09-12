import 'package:flutter/material.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: const Color(0xFFF5F5F5),
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          children: [
            const SizedBox(height: 60),
            // Logo & Title
            Column(
              children: [
                // Replace with your actual logo widget/image
                Image.asset(
                  'assets/Logo.png', // You should add your logo image here
                  height: 100,
                ),
                const SizedBox(height: 10),
                RichText(
                  text: const TextSpan(
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    children: [
                      TextSpan(
                        text: 'alert',
                        style: TextStyle(color: Color(0xFF213555)),
                      ),
                      TextSpan(
                        text: 'aid',
                        style: TextStyle(color: Colors.red),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),

            // Menu Items
            _buildDrawerItem(
                Icons.notifications, 'Alerts', context, '/emergencyAlerts'),
            _buildDrawerItem(Icons.feed, 'News Feed', context, '/newsfeed'),
            _buildDrawerItem(Icons.contacts, 'Contacts', context, '/contacts'),
            _buildDrawerItem(
                Icons.school, 'Knowledge Panel', context, '/knowledgePanel'),
            _buildDrawerItem(Icons.privacy_tip, 'Privacy Policy', context,
                '/privacy_policy'),
            _buildDrawerItem(Icons.person, 'Profile', context, '/profile'),
            _buildDrawerItem(Icons.logout, 'Logout', context, '/logout'),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  static Widget _buildDrawerItem(
    IconData icon,
    String title,
    BuildContext context,
    String routeName,
  ) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: Icon(icon, color: Color(0xFF213555)),
          title: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              color: Color(0xFF213555),
              fontWeight: FontWeight.w500,
            ),
          ),
          trailing: const Icon(Icons.arrow_forward_ios,
              size: 16, color: Color(0xFF213555)),
          onTap: () {
            Navigator.pop(context); // close drawer
            if (routeName == '/login') {
              // Handle logout explicitly
              Navigator.of(context).pushNamedAndRemoveUntil(
                '/login',
                (route) => false,
              );
            } else {
              Navigator.pushNamed(context, routeName); // <-- use pushNamed here
            }
          },
        ),
        const Divider(thickness: 0.8),
      ],
    );
  }
}
