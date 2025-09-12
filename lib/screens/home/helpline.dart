import 'package:flutter/material.dart';
import 'package:disaster_management/components/custom_bottom_navbar.dart';
import 'package:url_launcher/url_launcher.dart';

class HelplinePage extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const HelplinePage({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Helplines'),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            _buildHelplineCard(
                context, 'Medical Emergency', '1990', Colors.black),
            const SizedBox(height: 20),
            _buildHelplineCard(
                context, 'Police Emergency', '119', Colors.black),
            const SizedBox(height: 20),
            _buildHelplineCard(
                context, 'Disaster Management', '117', Colors.black),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: currentIndex,
        onItemTapped: (index) {
          if (index == currentIndex) return;

          String route = '';
          switch (index) {
            case 0:
              route = '/home';
              break;
            case 1:
              route = '/emergencyAlerts';
              break;
            case 2:
              route = '/newsfeed';
              break;
            case 3:
              route = '/profile';
              break;
          }

          if (route.isNotEmpty) {
            Navigator.pushNamedAndRemoveUntil(context, route, (route) => false);
          }
        },
      ),
    );
  }

  // Updated helpline card with external launch mode
  Widget _buildHelplineCard(
    BuildContext context,
    String title,
    String number,
    Color color,
  ) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: InkWell(
            onTap: () async {
              final Uri telUri = Uri.parse('tel:$number'); // <-- Change here
              if (await canLaunchUrl(telUri)) {
                await launchUrl(telUri, mode: LaunchMode.externalApplication);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Cannot make a call to $number')),
                );
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.all(10),
                        child: const Icon(
                          Icons.call,
                          color: Colors.white,
                          size: 32,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        number,
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: color,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
