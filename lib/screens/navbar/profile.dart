import 'dart:io';
import 'package:flutter/material.dart';
import 'package:disaster_management/components/custom_bottom_navbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:disaster_management/screens/onboarding/splash_screen.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isEditing = false;
  String? profileImageUrl;

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  @override
  void initState() {
    super.initState();
    fetchUserProfile();
  }

  Future<void> fetchUserProfile() async {
    User? user = _auth.currentUser;
    if (user != null) {
      try {
        DocumentSnapshot userDoc =
            await _firestore.collection('users').doc(user.uid).get();

        if (userDoc.exists) {
          Map<String, dynamic> data = userDoc.data() as Map<String, dynamic>;

          setState(() {
            fullNameController.text =
                '${data['firstName'] ?? ''} ${data['lastName'] ?? ''}'.trim();
            emailController.text = data['email'] ?? '';
            phoneController.text = data['phone'] ?? '';
            addressController.text = data['address'] ?? '';
            cityController.text = data['city'] ?? '';
            profileImageUrl = data['profileImageUrl'];
            passwordController.text = '';
          });
        }
      } catch (e) {
        print('Failed to fetch user profile: $e');
      }
    }
  }

  Future<void> _saveProfile() async {
    User? user = _auth.currentUser;
    if (user == null) return;

    List<String> nameParts = fullNameController.text.trim().split(' ');
    String firstName = nameParts.isNotEmpty ? nameParts.first : '';
    String lastName =
        nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '';

    try {
      await _firestore.collection('users').doc(user.uid).set({
        'firstName': firstName,
        'lastName': lastName,
        'phone': phoneController.text.trim(),
        'email': emailController.text.trim(),
        'address': addressController.text.trim(),
        'city': cityController.text.trim(),
        'profileImageUrl': profileImageUrl ?? '',
      }, SetOptions(merge: true));

      if (emailController.text.trim() != user.email) {
        await user.updateEmail(emailController.text.trim());
      }

      if (passwordController.text.isNotEmpty) {
        await user.updatePassword(passwordController.text);
      }

      await user.reload();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated successfully')),
      );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update profile: ${e.message}')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update profile: $e')),
      );
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      User? user = _auth.currentUser;

      if (user != null) {
        try {
          final ref =
              _storage.ref().child('profile_images').child('${user.uid}.jpg');

          await ref.putFile(imageFile);
          final url = await ref.getDownloadURL();

          setState(() {
            profileImageUrl = url;
          });

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Profile picture updated.')),
          );
        } catch (e) {
          print('Image upload error: $e');
        }
      }
    }
  }

  @override
  void dispose() {
    fullNameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    addressController.dispose();
    cityController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.redAccent),
            onPressed: () async {
              await _auth.signOut();
              if (!mounted) return;

              Fluttertoast.showToast(
                msg: 'Log Out Successful\nSee you soon!',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0,
              );

              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const SplashScreen()),
                (route) => false,
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.grey[200],
                        backgroundImage: profileImageUrl != null
                            ? NetworkImage(profileImageUrl!)
                            : null,
                        child: profileImageUrl == null
                            ? const Icon(Icons.person, size: 50)
                            : null,
                      ),
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.green,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          icon: const Icon(Icons.edit,
                              size: 15, color: Colors.white),
                          onPressed: _pickImage,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          _buildEditableField('Full Name', fullNameController),
                          _buildEditableField('Mobile Phone', phoneController),
                          _buildEditableField('E-mail', emailController),
                          _buildEditableField('Address', addressController),
                          _buildEditableField('City', cityController),
                          _buildEditableField('Password', passwordController,
                              isPassword: true),
                          const SizedBox(height: 30),
                          ElevatedButton.icon(
                            onPressed: () async {
                              await _saveProfile();
                              passwordController.clear();
                            },
                            label: const Text("Save"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 142, 243, 122),
                              foregroundColor:
                                  const Color.fromARGB(255, 0, 0, 0),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: 3,
        onItemTapped: (int index) {
          switch (index) {
            case 0:
              Navigator.pushReplacementNamed(context, '/home');
              break;
            case 1:
              Navigator.pushReplacementNamed(context, '/emergencyAlerts');
              break;
            case 2:
              Navigator.pushReplacementNamed(context, '/newsfeed');
              break;
            case 3:
              break;
          }
        },
      ),
    );
  }

  bool isEditingFullName = false;
  bool isEditingPhone = false;
  bool isEditingEmail = false;
  bool isEditingAddress = false;
  bool isEditingCity = false;
  bool isEditingPassword = false;

  Widget _buildEditableField(String label, TextEditingController controller,
      {bool isPassword = false}) {
    late bool isEditingField;
    late void Function(bool) setEditing;

    switch (label) {
      case 'Full Name':
        isEditingField = isEditingFullName;
        setEditing = (val) => setState(() => isEditingFullName = val);
        break;
      case 'Mobile Phone':
        isEditingField = isEditingPhone;
        setEditing = (val) => setState(() => isEditingPhone = val);
        break;
      case 'E-mail':
        isEditingField = isEditingEmail;
        setEditing = (val) => setState(() => isEditingEmail = val);
        break;
      case 'Address':
        isEditingField = isEditingAddress;
        setEditing = (val) => setState(() => isEditingAddress = val);
        break;
      case 'City':
        isEditingField = isEditingCity;
        setEditing = (val) => setState(() => isEditingCity = val);
        break;
      case 'Password':
        isEditingField = isEditingPassword;
        setEditing = (val) => setState(() => isEditingPassword = val);
        break;
      default:
        isEditingField = false;
        setEditing = (_) {};
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
              if (!isEditingField)
                IconButton(
                  icon: const Icon(Icons.edit, size: 18, color: Colors.grey),
                  onPressed: () => setEditing(true),
                ),
            ],
          ),
          const SizedBox(height: 4),
          isEditingField
              ? TextField(
                  controller: controller,
                  obscureText: isPassword,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 12.0),
                  ),
                )
              : Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text(
                      isPassword
                          ? '•' * controller.text.length
                          : controller.text,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
