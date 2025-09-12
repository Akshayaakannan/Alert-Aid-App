import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:disaster_management/components/custom_bottom_navbar.dart';
import 'package:disaster_management/services/data_store.dart';

class EmergencyAlertsPage extends StatefulWidget {
  const EmergencyAlertsPage({super.key});

  @override
  State<EmergencyAlertsPage> createState() => _EmergencyAlertsPageState();
}

class _EmergencyAlertsPageState extends State<EmergencyAlertsPage> {
  List<IncidentReport> _activeAlerts = [];
  String? _userCity;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadUserCityAndAlerts();
  }

  Future<void> _loadUserCityAndAlerts() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) throw Exception("User not logged in.");

      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      final city = userDoc.data()?['city'] as String?;
      if (city == null || city.isEmpty) {
        throw Exception("City not found in user data.");
      }

      final reports = await getMatchingIncidents(city);

      setState(() {
        _userCity = city;
        _activeAlerts = reports;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Emergency Alerts'),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : _errorMessage != null
                ? Center(
                    child: Text(
                      _errorMessage!,
                      style: const TextStyle(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                  )
                : _activeAlerts.isEmpty
                    ? Center(
                        child: Text(
                          _userCity != null
                              ? 'No incidents currently reported for $_userCity.'
                              : 'No incidents reported or city not set.',
                          textAlign: TextAlign.center,
                          style:
                              const TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      )
                    : ListView.builder(
                        itemCount: _activeAlerts.length,
                        itemBuilder: (context, index) {
                          final incident = _activeAlerts[index];
                          return _IncidentAlertItem(incident: incident);
                        },
                      ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: 1,
        onItemTapped: (index) {
          if (index == 1) return;

          final routes = ['/home', '/alerts', '/newsfeed', '/profile'];
          final route = routes[index];

          Navigator.pushNamedAndRemoveUntil(context, route, (route) => false);
        },
      ),
    );
  }
}

class _IncidentAlertItem extends StatelessWidget {
  final IncidentReport incident;

  const _IncidentAlertItem({required this.incident});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade300),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(
              Icons.warning_amber_rounded,
              color: Colors.red,
              size: 36,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Incident: ${incident.disasterType}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Location: ${incident.location}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Details: ${incident.description}',
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Reported by: ${incident.fullName}',
                    style: const TextStyle(
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
