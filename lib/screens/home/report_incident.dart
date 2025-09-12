import 'dart:io';
import 'package:disaster_management/screens/navbar/home.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:disaster_management/services/data_store.dart';

class ReportIncidentPage extends StatefulWidget {
  final int? currentIndex;
  final Function(int)? onTap;

  const ReportIncidentPage({
    super.key,
    this.currentIndex,
    this.onTap,
  });

  @override
  State<ReportIncidentPage> createState() => _ReportIncidentPageState();
}

class _ReportIncidentPageState extends State<ReportIncidentPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  String? _selectedIncidentType;
  String? _selectedLocation;
  File? _selectedImage;

  final List<String> _incidentTypes = [
    'Flood',
    'Landslide',
    'Tsunami',
    'Cyclone',
    'Fire',
    'Earthquake',
    'Other'
  ];

  final List<String> _locations = [
    'Colombo',
    'Kandy',
    'Galle',
    'Jaffna',
    'Negombo',
    'Trincomalee',
    'Batticaloa',
    'Matara',
    'Other'
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  Future<String?> _uploadImage(File image) async {
    try {
      final fileName = DateTime.now().millisecondsSinceEpoch.toString();
      final storageRef =
          FirebaseStorage.instance.ref().child('incident_images/$fileName.jpg');
      await storageRef.putFile(image);
      return await storageRef.getDownloadURL();
    } catch (e) {
      _showSnackBar('Image upload failed');
      return null;
    }
  }

  void _submitReport() async {
    if (_nameController.text.isEmpty) {
      _showSnackBar('Please enter your full name');
      return;
    }
    if (_selectedIncidentType == null) {
      _showSnackBar('Please select an incident type');
      return;
    }
    if (_descriptionController.text.isEmpty) {
      _showSnackBar('Please provide a brief description');
      return;
    }
    if (_selectedLocation == null) {
      _showSnackBar('Please select a location');
      return;
    }

    String? imageUrl;
    if (_selectedImage != null) {
      imageUrl = await _uploadImage(_selectedImage!);
      if (imageUrl == null) {
        // If upload fails, ask user if they want to continue without image
        final shouldContinue = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Image Upload Failed'),
            content:
                const Text('Failed to upload image. Continue without image?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text('Continue'),
              ),
            ],
          ),
        );

        if (shouldContinue != true) {
          return;
        }
      }
    }

    final newReport = IncidentReport(
      fullName: _nameController.text,
      disasterType: _selectedIncidentType!,
      description: _descriptionController.text,
      location: _selectedLocation!,
      imageUrl: imageUrl,
    );

    await saveIncidentToFirestore(newReport);

    _showSnackBar('Report submitted successfully!');
    _clearForm();

    // Navigate to Home screen after successful report submission
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
          builder: (_) => HomeScreen()), // Replace with your actual Home widget
    );
  }

  void _clearForm() {
    _nameController.clear();
    _descriptionController.clear();
    setState(() {
      _selectedIncidentType = null;
      _selectedLocation = null;
      _selectedImage = null;
    });
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: const Duration(seconds: 2)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final formWidth = screenWidth * 0.85;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Report Incident',
          style: TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 255, 201, 153),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: SizedBox(
            width: formWidth,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildLabel('Full Name'),
                _buildTextField(_nameController, 'Add your full name'),
                const SizedBox(height: 24),
                _buildLabel('Incident Type'),
                _buildDropdown(
                    _incidentTypes,
                    _selectedIncidentType,
                    'Select Incident Type',
                    (value) => setState(() => _selectedIncidentType = value)),
                const SizedBox(height: 24),
                _buildLabel('Brief Description'),
                _buildTextField(_descriptionController,
                    'Severity and impact of the incident',
                    maxLines: 4),
                const SizedBox(height: 24),
                _buildLabel('Location'),
                _buildDropdown(
                    _locations,
                    _selectedLocation,
                    'Select the location',
                    (value) => setState(() => _selectedLocation = value)),
                const SizedBox(height: 32),

                // Image Upload UI
                GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    width: double.infinity,
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey[300]!, width: 1),
                    ),
                    child: _selectedImage == null
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.image_outlined,
                                  size: 40, color: Colors.grey[400]),
                              const SizedBox(height: 8),
                              Text('Tap to add image',
                                  style: TextStyle(
                                      color: Colors.grey[500], fontSize: 14)),
                            ],
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.file(_selectedImage!,
                                fit: BoxFit.cover, width: double.infinity),
                          ),
                  ),
                ),

                const SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _submitReport,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      elevation: 0,
                    ),
                    child: const Text('Submit',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white)),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(text,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500));
  }

  Widget _buildTextField(TextEditingController controller, String hint,
      {int maxLines = 1}) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey[500]),
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
    );
  }

  Widget _buildDropdown(
    List<String> items,
    String? selectedItem,
    String hint,
    void Function(String?) onChanged,
  ) {
    return DropdownButtonFormField<String>(
      value: selectedItem,
      hint: Text(hint, style: TextStyle(color: Colors.grey[500])),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      items: items
          .map((value) =>
              DropdownMenuItem<String>(value: value, child: Text(value)))
          .toList(),
      onChanged: onChanged,
    );
  }
}
