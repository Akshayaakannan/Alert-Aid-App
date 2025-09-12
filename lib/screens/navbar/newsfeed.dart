import 'package:flutter/material.dart';
import 'package:disaster_management/components/custom_bottom_navbar.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsfeedPage extends StatelessWidget {
  const NewsfeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Newsfeed'),
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
        child: ListView(
          children: const [
            _NewsItem(
              title: 'අකුණු අනතුරු වලින් ආරක්ෂා වෙමු.',
              description:
                  'පළමු අන්තර් මෝසම් කාලසීමාව වන මාර්තු සිට අප්‍රේල් දක්වා කාලසීමාට තුළ අපට අකුණු අනතුරු බහුලව වාර්තාවන කාලසීමාවක් වන බැවින් අප අකුණු අනතුරු අවම කරගැනීමට කටයුතු කළ යුතු වන අතර...',
              imagePath: 'assets/news1.jpg',
              newsUrl:
                  'https://www.dmc.gov.lk/index.php?option=com_content&view=article&id=1659:2025-04-02-11-25-06&catid=8&Itemid=125&lang=en',
            ),
            SizedBox(height: 16),
            _NewsItem(
              title: 'දිවයිනේ ප්‍රදේශ කීපයකට මිලිමීටර් 100 ය ඉක්ම වූ වැසි.',
              description:
                  'වයඹ සහ උතුරු-මැද පළාත්වලත් මන්නාරම සහ වව්නියා දිස්ත්‍රික්කවලත් ඇතැම් ස්ථානවලට මි.මී. 100ට වැඩි තද වැසි ඇති විය හැකි බව කාලගුණවිද්‍ය දෙපාර්තමේන්තුව නිවේදනය කර ඇත...',
              imagePath: 'assets/news2.jpg',
              newsUrl:
                  'https://www.dmc.gov.lk/index.php?option=com_content&view=article&id=1657:100-2&catid=8&Itemid=125&lang=en',
            ),
            SizedBox(height: 16),
            _NewsItem(
              title:
                  'පුත්තලම සිට මුලතිව් දක්වා මුහුදු ප්‍රදේශවල ධීවර සහ නාවික කටයුතු වලින් වැළකී සිටිනමෙන් දැනුම්දීම්ක්',
              description:
                  'නිරිත දිග බෙංගාල බොක්ක මුහුදු ප්‍රදේශයේ සක්‍රීය වි ඇති අඩු පීඩන කලාපය තවදුරටත් පවතින බවත් එය ඉදිරි පැය 24 තුළ බටහිරට බරව වයඔ දෙසට ගමන් කරමින් ශ්‍රී ලංකාවේ...',
              imagePath: 'assets/news3.jpg',
              newsUrl:
                  'https://www.dmc.gov.lk/index.php?option=com_content&view=article&id=1596:2024-12-11-05-20-56&catid=8&Itemid=125&lang=en',
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: 2,
        onItemTapped: (index) {
          switch (index) {
            case 0:
              Navigator.pushReplacementNamed(context, '/home');
              break;
            case 1:
              Navigator.pushReplacementNamed(context, '/emergencyAlerts');
              break;
            case 2:
              // Already on Newsfeed page
              break;
            case 3:
              Navigator.pushReplacementNamed(context, '/profile');
              break;
          }
        },
      ),
    );
  }
}

class _NewsItem extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;
  final String newsUrl;

  const _NewsItem({
    required this.title,
    required this.description,
    required this.imagePath,
    required this.newsUrl,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final Uri url = Uri.parse(newsUrl);
        if (!await canLaunchUrl(url)) {
          print('Could not launch $newsUrl');
        } else {
          await launchUrl(url);
        }
      },
      child: Card(
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: Colors.grey.shade200, width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  height: 180,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(imagePath),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        description,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
                      color: Colors.grey[600],
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
