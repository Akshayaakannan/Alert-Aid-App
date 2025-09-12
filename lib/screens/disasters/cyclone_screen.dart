import 'package:flutter/material.dart';
import 'package:disaster_management/components/custom_bottom_navbar.dart';

class CycloneScreen extends StatefulWidget {
  const CycloneScreen({super.key});

  @override
  State<CycloneScreen> createState() => _CycloneScreenState();
}

class _CycloneScreenState extends State<CycloneScreen> {
  final int _selectedIndex = 0;
  int _currentPage = 0;
  final PageController _pageController = PageController(viewportFraction: 0.85);

  // List of image asset paths
  final List<String> cycloneImages = [
    'assets/cyclone 1.jpg',
    'assets/cyclone 2.png',
    'assets/cyclone 3.jpg',
    'assets/cyclone 4.jpg',
    'assets/cyclone 5.png'
  ];

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      int next = _pageController.page!.round();
      if (_currentPage != next) {
        setState(() {
          _currentPage = next;
        });
      }
    });
  }

  void _onItemTapped(int index) {
    if (index == _selectedIndex) return;

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.arrow_back, size: 24),
                    ),
                    const SizedBox(height: 20),
                    const Center(
                      child: Text(
                        'Cyclone',
                        style: TextStyle(
                          fontSize: 24,
                          fontFamily: 'poppins',
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF1A1D1E),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 34.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    SizedBox(height: 20),
                    Text(
                      'Early Warning Signs :',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'poppins',
                        color: Color(0xFF1A1D1E),
                      ),
                    ),
                    SizedBox(height: 8),
                    Text.rich(
                      TextSpan(
                        style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'poppins',
                            color: Color(0xFF1A1D1E)),
                        children: [
                          TextSpan(
                              text: 'Sudden Drop in Air Pressure: ',
                              style: TextStyle(fontWeight: FontWeight.w600)),
                          TextSpan(
                              text:
                                  'A significant and rapid decrease in air pressure may signal the approach of a cyclone.'),
                        ],
                      ),
                    ),
                    SizedBox(height: 8),
                    Text.rich(
                      TextSpan(
                        style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'poppins',
                            color: Color(0xFF1A1D1E)),
                        children: [
                          TextSpan(
                              text:
                                  'Increased Water Levels in Drainage Systems: ',
                              style: TextStyle(fontWeight: FontWeight.w600)),
                          TextSpan(
                              text:
                                  'Rising water levels in storm drains may indicate flooding caused by cyclones.'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Column(
                children: [
                  SizedBox(
                    height: 300,
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: cycloneImages.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Container(
                            width: double.infinity,
                            height: 300,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              image: DecorationImage(
                                image: AssetImage(cycloneImages[index]),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(cycloneImages.length, (index) {
                      final bool isActive = _currentPage == index;
                      return GestureDetector(
                        onTap: () {
                          _pageController.animateToPage(
                            index,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: isActive ? 20 : 8,
                          height: 8,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: const Color.fromARGB(255, 131, 135, 136)
                                .withOpacity(isActive ? 1.0 : 0.3),
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const Opacity(
                opacity: 0.3,
                child: Divider(
                  color: Color.fromARGB(255, 0, 0, 0),
                  thickness: 1,
                  indent: 31,
                  endIndent: 30,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 34.0, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Safety Tips',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'poppins',
                        color: Color(0xFF1A1D1E),
                      ),
                    ),
                    SizedBox(height: 8),
                    Text.rich(
                      TextSpan(
                        style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'poppins',
                            color: Color(0xFF1A1D1E)),
                        children: [
                          TextSpan(
                              text: 'Evacuate Early: ',
                              style: TextStyle(fontWeight: FontWeight.w600)),
                          TextSpan(
                              text:
                                  'If local authorities issue evacuation orders, follow them promptly to avoid danger.'),
                        ],
                      ),
                    ),
                    SizedBox(height: 8),
                    Text.rich(
                      TextSpan(
                        style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'poppins',
                            color: Color(0xFF1A1D1E)),
                        children: [
                          TextSpan(
                              text: 'Prepare Emergency Supplies: ',
                              style: TextStyle(fontWeight: FontWeight.w600)),
                          TextSpan(
                              text:
                                  'Keep an emergency kit with water, food, medications, flashlight, and documents.'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
