import 'package:cloud_firestore/cloud_firestore.dart';

class IncidentReport {
  final String fullName;
  final String disasterType;
  final String description;
  final String location;
  final String? imageUrl;

  IncidentReport({
    required this.fullName,
    required this.disasterType,
    required this.description,
    required this.location,
    this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'fullName': fullName,
      'disasterType': disasterType,
      'description': description,
      'location': location,
      'location_lowercase': location.toLowerCase(),
      'imageUrl': imageUrl ?? '',
      'timestamp': FieldValue.serverTimestamp(),
    };
  }
}

// Save to Firestore
Future<void> saveIncidentToFirestore(IncidentReport report) async {
  await FirebaseFirestore.instance
      .collection('incident_reports')
      .add(report.toMap());
}

// Fetch matching incidents based on lowercase city name
Future<List<IncidentReport>> getMatchingIncidents(String city) async {
  try {
    final cityLower = city.toLowerCase();
    print("Searching incidents for city: $cityLower");

    final querySnapshot = await FirebaseFirestore.instance
        .collection('incident_reports')
        .where('location_lowercase', isEqualTo: cityLower)
        .orderBy('timestamp', descending: true)
        .get();

    print("Found ${querySnapshot.docs.length} incidents for city $city");

    return querySnapshot.docs.map((doc) {
      final data = doc.data();
      return IncidentReport(
        fullName: data['fullName'] ?? '',
        disasterType: data['disasterType'] ?? '',
        description: data['description'] ?? '',
        location: data['location'] ?? '',
        imageUrl: data['imageUrl'],
      );
    }).toList();
  } catch (e) {
    print("Error fetching incidents: $e");
    return [];
  }
}
