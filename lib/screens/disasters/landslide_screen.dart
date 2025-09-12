import 'package:flutter/material.dart';
import 'package:disaster_management/components/custom_bottom_navbar.dart';

class LandslideScreen extends StatefulWidget {
  const LandslideScreen({super.key});

  @override
  State<LandslideScreen> createState() => _LandslideScreenState();
}

class _LandslideScreenState extends State<LandslideScreen> {
  int _selectedIndex = 0;
  int _currentPage = 0;
  final PageController _pageController = PageController(viewportFraction: 0.7);

  final List<String> imagePaths = [
    'assets/landslide 1.jpg',
    'assets/landslide 2.jpg',
    'assets/landslide 3.jpg',
    'assets/landslide 4.jpg',
    'assets/landslide 5.jpg',
  ];

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);

    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/home');
        break;
      case 1:
        Navigator.pushNamed(context, '/alerts');
        break;
      case 2:
        Navigator.pushNamed(context, '/newsfeed');
        break;
      case 3:
        Navigator.pushNamed(context, '/profile');
        break;
    }
  }

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
              // Header and Title
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
                        'Landslide',
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

              // Early Warning Signs
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 34.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    SizedBox(height: 20),
                    Text(
                      'Early Warning Signs:',
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
                          color: Color(0xFF1A1D1E),
                        ),
                        children: [
                          TextSpan(
                              text: 'Cracking or Bulging Soil: ',
                              style: TextStyle(fontWeight: FontWeight.w600)),
                          TextSpan(
                              text:
                                  'Noticeable cracks or bulges in the soil on slopes indicate potential movement underground.'),
                        ],
                      ),
                    ),
                    SizedBox(height: 8),
                    Text.rich(
                      TextSpan(
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'poppins',
                          color: Color(0xFF1A1D1E),
                        ),
                        children: [
                          TextSpan(
                              text: 'Tilting Trees or Poles: ',
                              style: TextStyle(fontWeight: FontWeight.w600)),
                          TextSpan(
                              text:
                                  'Trees, fences, or poles leaning downhill can be an early indicator of ground movement.'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Carousel with actual images
              SizedBox(
                height: 160,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: imagePaths.length,
                  itemBuilder: (context, index) {
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 6,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.asset(
                          imagePaths[index],
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 12),

              // Indicator Dots
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(imagePaths.length, (index) {
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
                      duration: const Duration(milliseconds: 300),
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

              const SizedBox(height: 16),

              // Divider
              Opacity(
                opacity: 0.3,
                child: Divider(
                  color: Colors.black,
                  thickness: 1,
                  indent: 31,
                  endIndent: 30,
                ),
              ),

              // Safety Tips
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
                          color: Color(0xFF1A1D1E),
                        ),
                        children: [
                          TextSpan(
                              text: 'Stay Alert: ',
                              style: TextStyle(fontWeight: FontWeight.w600)),
                          TextSpan(
                              text:
                                  'Be aware of unusual sounds like trees cracking or rocks moving downhill.'),
                        ],
                      ),
                    ),
                    SizedBox(height: 8),
                    Text.rich(
                      TextSpan(
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'poppins',
                          color: Color(0xFF1A1D1E),
                        ),
                        children: [
                          TextSpan(
                              text: 'Evacuate Immediately: ',
                              style: TextStyle(fontWeight: FontWeight.w600)),
                          TextSpan(
                              text:
                                  'If you observe signs of landslide or ground movement, evacuate to safer ground without delay.'),
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
