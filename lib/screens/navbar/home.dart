import 'package:flutter/material.dart';
import 'alerts.dart';
import 'newsfeed.dart';
import 'package:disaster_management/screens/chatbot/aiassistantpage.dart';
import 'package:disaster_management/screens/navbar/profile.dart';
import 'package:disaster_management/screens/home/contacts.dart';
import 'package:disaster_management/screens/home/helpline.dart';
import 'package:disaster_management/screens/home/knowledge_panel.dart';
import 'package:disaster_management/screens/home/report_incident.dart';
import 'package:disaster_management/screens/side_menu.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  bool _hasNewAlert = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SideMenu(), // <<--- ADD SIDEMENU HERE
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('AlertAid'),
        centerTitle: true,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.notifications),
                onPressed: () {
                  setState(() {
                    _hasNewAlert = false;
                  });
                  _navigateToScreen(const EmergencyAlertsPage());
                },
              ),
              if (_hasNewAlert)
                Positioned(
                  right: 15,
                  top: 14,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.green, // ✅ GREEN for new alerts
                      borderRadius: BorderRadius.circular(6),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 8,
                      minHeight: 8,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                'Welcome To AlertAid',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 8),
            const Center(
              child: Text(
                'Stay informed, stay prepared,\nand stay safe with real-time alerts.',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                children: [
                  _buildFeatureButton(
                      'AI Assistant',
                      Icons.smart_toy,
                      Colors.blue,
                      () => _navigateToScreen(const AssistantScreen())),
                  _buildFeatureButton(
                      'Contacts',
                      Icons.contacts,
                      Colors.green,
                      () => _navigateToScreen(ContactsPage(
                          currentIndex: 0, onTap: (int index) {}))),
                  _buildFeatureButton(
                      'Knowledge Panel',
                      Icons.library_books,
                      Colors.purple,
                      () => _navigateToScreen(KnowledgePanelPage(
                          currentIndex: 0, onTap: (int index) {}))),
                  _buildFeatureButton(
                      'Report Incident',
                      Icons.report,
                      Colors.orange,
                      () => _navigateToScreen(ReportIncidentPage(
                          currentIndex: 0, onTap: (int index) {}))),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Center(
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      _navigateToScreen(
                          HelplinePage(currentIndex: 0, onTap: (int index) {}));
                    },
                    icon: const Icon(Icons.emergency, color: Colors.white),
                    label: const Text(
                      'EMERGENCY HELPLINE',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications), label: 'Alerts'),
          BottomNavigationBarItem(icon: Icon(Icons.newspaper), label: 'News'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        break;
      case 1:
        _navigateToScreen(const EmergencyAlertsPage());
        break;
      case 2:
        _navigateToScreen(const NewsfeedPage());
        break;
      case 3:
        _navigateToScreen(const ProfilePage());
        break;
    }
  }

  void _navigateToScreen(Widget screen) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
  }

  Widget _buildFeatureButton(
      String title, IconData icon, Color color, VoidCallback onPressed) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 32),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
