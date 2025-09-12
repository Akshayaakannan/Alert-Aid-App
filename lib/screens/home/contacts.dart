import 'package:flutter/material.dart';
import 'package:disaster_management/components/custom_bottom_navbar.dart';

class ContactsPage extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const ContactsPage({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final contacts = [
      ['Police Emergency Hotline', '118/119'],
      ['Police Emergency', '011 2433333'],
      ['Police Headquarters', '011 2421111'],
      ['Emergency Police Mobile Squad', '011 5717171'],
      ['Government Information Center', '1919'],
      [], // Empty row to add spacing
      ['Ambulance/Fire & rescue', '110'],
      ['Suwa Seriya Hotline', '1990'],
      ['Accident Service - Colombo', '011 2691111'],
    ];

    final fireAndOpsContacts = [
      ['Fire & Ambulance Service', '011 2422222'],
      ['Emergency Operation Center', '011 2136222'],
      ['Emergency Operation Center', '011 2670002'],
    ];

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Emergency Contacts'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 106, 211, 148),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 80),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    children: const [
                      Expanded(
                        child: Text(
                          'Emergency Services',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'Contact No.',
                          style: TextStyle(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ...contacts.map((contact) {
                    if (contact.isEmpty) {
                      return const SizedBox(height: 20); // Extra space
                    }
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              contact[0],
                              style: const TextStyle(fontSize: 14),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              contact[1],
                              style: const TextStyle(fontSize: 14),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                  const SizedBox(height: 20),
                  ...fireAndOpsContacts.map((contact) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                contact[0],
                                style: const TextStyle(fontSize: 14),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                contact[1],
                                style: const TextStyle(fontSize: 14),
                                textAlign: TextAlign.right,
                              ),
                            ),
                          ],
                        ),
                      )),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: () {
                // Add call functionality here if desired
              },
              child: const Text(
                'Emergency Hotline - 117',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: 0,
        onItemTapped: (index) {
          if (index == 1) return; // Already on Alerts page

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
}
