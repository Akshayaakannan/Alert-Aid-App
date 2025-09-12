import 'package:flutter/material.dart';
import 'package:disaster_management/components/custom_bottom_navbar.dart';

class FloodScreen extends StatefulWidget {
  const FloodScreen({super.key});

  @override
  State<FloodScreen> createState() => _FloodScreenState();
}

class _FloodScreenState extends State<FloodScreen> {
  int _selectedIndex = 0;
  int _currentPage = 0;
  final PageController _pageController = PageController(viewportFraction: 0.7);

  final List<String> imagePaths = [
    'assets/flood 1.jpg',
    'assets/flood 2.jpg',
    'assets/flood 3.jpg',
    'assets/flood 4.jpg',
    'assets/flood 5.jpg',
    'assets/flood 6.jpg',
    'assets/flood 7.jpg',
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

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
                        'Flood',
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
                    WarningText(
                      title: 'Sudden Increase in Water Levels: ',
                      description:
                          'Rapidly rising water in rivers, streams, or nearby drainage systems can signal imminent flooding.',
                    ),
                    WarningText(
                      title: 'Heavy and Continuous Rainfall: ',
                      description:
                          'Prolonged and intense rain often causes water bodies to overflow.',
                    ),
                    WarningText(
                      title: 'Water Backing Up in Drains and Sewers: ',
                      description:
                          'Water flowing backward or pooling in drainage systems can be a sign of flooding.',
                    ),
                    WarningText(
                      title: 'Overflowing Rivers and Canals: ',
                      description:
                          'When rivers and canals start to spill over their banks, flooding is likely to occur.',
                    ),
                    WarningText(
                      title: 'Reports and Alerts from Authorities: ',
                      description:
                          'Pay attention to official flood warnings issued by meteorological and disaster management agencies.',
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Carousel with Images
              Column(
                children: [
                  SizedBox(
                    height: 300,
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: imagePaths.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
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

              const SizedBox(height: 20),

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
                    WarningText(
                      title: 'Move to Higher Ground Immediately: ',
                      description:
                          'If flooding is imminent, evacuate to higher areas and avoid low-lying regions.',
                    ),
                    WarningText(
                      title: 'Avoid Walking or Driving Through Floodwaters: ',
                      description:
                          'Just 6 inches of moving water can knock a person down, and 12 inches can sweep a vehicle away.',
                    ),
                    WarningText(
                      title: 'Secure Important Documents and Valuables: ',
                      description:
                          'Keep your important documents in waterproof containers or bags.',
                    ),
                    WarningText(
                      title: 'Turn Off Utilities if Safe to Do So: ',
                      description:
                          'Switch off electricity, gas, and water supply to prevent accidents.',
                    ),
                    WarningText(
                      title: 'Keep Emergency Supplies Ready: ',
                      description:
                          'Have food, water, medications, and a flashlight ready in case you are trapped or isolated.',
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

// Widget for repeated warning text blocks
class WarningText extends StatelessWidget {
  final String title;
  final String description;

  const WarningText({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(
          fontSize: 12,
          fontFamily: 'poppins',
          color: Color(0xFF1A1D1E),
        ),
        children: [
          TextSpan(
            text: title,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          TextSpan(text: description),
        ],
      ),
    );
  }
}
