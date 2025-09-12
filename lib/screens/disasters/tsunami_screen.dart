import 'package:flutter/material.dart';
import 'package:disaster_management/components/custom_bottom_navbar.dart';

class TsunamiScreen extends StatefulWidget {
  const TsunamiScreen({super.key});

  @override
  State<TsunamiScreen> createState() => _TsunamiScreenState();
}

class _TsunamiScreenState extends State<TsunamiScreen> {
  int _selectedIndex = 0;
  int _currentPage = 0;
  final PageController _pageController = PageController(viewportFraction: 0.45);

  final List<String> imagePaths = [
    'assets/tsunami 1.jpg',
    'assets/tsunami 2.jpg',
    'assets/tsunami 3.jpg',
    'assets/tsunami 4.jpg',
    'assets/tsunami 5.jpg'
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
  void dispose() {
    _pageController.dispose();
    super.dispose();
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
                        'Tsunami',
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
                  children: [
                    const SizedBox(height: 20),
                    const Text(
                      'Early Warning Signs :',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'poppins',
                        color: Color(0xFF1A1D1E),
                      ),
                    ),
                    const SizedBox(height: 8),
                    RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'poppins',
                          color: Color(0xFF1A1D1E),
                        ),
                        children: [
                          TextSpan(
                            text: 'Strong Earthquake Near Coast: ',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          TextSpan(
                            text:
                                'A strong or long earthquake near the ocean can be a precursor to a tsunami, especially if it lasts longer than 20 seconds.',
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'poppins',
                          color: Color(0xFF1A1D1E),
                        ),
                        children: [
                          TextSpan(
                            text: 'Sudden Sea Withdrawal: ',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          TextSpan(
                            text:
                                'A noticeable receding of the sea, exposing the sea floor, reefs, and fish, may signal an approaching tsunami.',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Carousel
              Column(
                children: [
                  SizedBox(
                    height: 120,
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: imagePaths.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: SizedBox(
                            width: 109.58,
                            height: 127.84,
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFFD9D9D9),
                                borderRadius: BorderRadius.circular(16),
                                image: DecorationImage(
                                  image: AssetImage(imagePaths[index]),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Custom Indicator Dots
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

              // Horizontal bar indicator (below carousel)
              const SizedBox(height: 12),
              Opacity(
                opacity: 0.3,
                child: Divider(
                  color: Colors.black, // line color
                  thickness: 1, // line thickness
                  indent: 31, // left padding
                  endIndent: 30, // right padding
                ),
              ),

              // Safety Tips
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 34.0, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Safety Tips',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'poppins',
                        color: Color(0xFF1A1D1E),
                      ),
                    ),
                    const SizedBox(height: 8),
                    RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'poppins',
                          color: Color(0xFF1A1D1E),
                        ),
                        children: [
                          TextSpan(
                            text: 'Move to Higher Ground: ',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          TextSpan(
                            text:
                                'If you are near the coast and feel a strong earthquake, evacuate to higher ground immediately and do not wait for official warnings.',
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'poppins',
                          color: Color(0xFF1A1D1E),
                        ),
                        children: [
                          TextSpan(
                            text: 'Stay Away from the Beach: ',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          TextSpan(
                            text:
                                'Do not go to the shore to watch the tsunami. Tsunamis move faster than people can run and can cause multiple surges.',
                          ),
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
