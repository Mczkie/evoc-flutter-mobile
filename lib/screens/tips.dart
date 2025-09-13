import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MyTips extends StatelessWidget {
  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  const MyTips({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          "Waste Segregation",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.teal[700],
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Hero Card
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Container(
                    height: 180,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      gradient: LinearGradient(
                        colors: [Colors.teal[700]!, Colors.teal[500]!],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: Opacity(
                            opacity: 0.2,
                            child: Icon(
                              Icons.recycling,
                              size: 150,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Smart Waste Management",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "7 Essential Tips for Proper Waste Segregation",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white.withOpacity(0.9),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Section Header
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    children: [
                      Icon(Icons.article, color: Colors.teal[700], size: 24),
                      const SizedBox(width: 8),
                      Text(
                        'WASTE SEGREGATION ARTICLES',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal[700],
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Policy Card (Different style to highlight importance)
                _buildPolicyCard(
                  "DM No. 268, s. 2023 – STRICT IMPLEMENTATION OF NO SEGREGATION, NO COLLECTION OF GARBAGE POLICY WITHIN OLONGAPO CITY",
                  "https://deped-olongapo.com/dm-no-268-s-2023-strict-emplementation-of-no-segregation-no-collection-of-garbage-policy-within-olongapo-city/",
                ),

                // Tips List
                _buildTipCard(
                  Icons.category,
                  "Segregation Basics",
                  "Separate waste into biodegradable, non-biodegradable, and hazardous categories for efficient recycling.",
                  Colors.orange[700]!,
                  "https://www.youtube.com/watch?v=Qyu-fZ8BOnI",
                ),
                _buildTipCard(
                  Icons.label,
                  "Clear Labeling",
                  "Use separate bins with clear labels to help everyone in your household dispose waste properly.",
                  Colors.blue[700]!,
                  "https://www.youtube.com/watch?v=VQTtg3KgVv4",
                ),
                _buildTipCard(
                    Icons.clean_hands,
                    "Clean Before Disposal",
                    "Rinse plastic and glass containers before disposal to prevent contamination of recyclables.",
                    Colors.green[700]!,
                    "https://www.youtube.com/watch?v=IisgnbMfKvI"),
                _buildTipCard(
                    Icons.eco,
                    "Compost Organics",
                    "Compost food scraps and organic waste to reduce landfill waste and create nutrient-rich soil.",
                    Colors.brown[700]!,
                    "https://www.youtube.com/watch?v=Z8eYd7k2r0g"),
                _buildTipCard(
                    Icons.shopping_bag,
                    "Reduce Plastics",
                    "Avoid single-use plastics by opting for reusable bags, bottles, and containers.",
                    Colors.purple[700]!,
                    "https://www.youtube.com/watch?v=HQT5kNw3n9A"),
                _buildTipCard(
                    Icons.warning,
                    "Hazardous Waste",
                    "Dispose of batteries and chemicals at designated centers to prevent environmental harm.",
                    Colors.red[700]!,
                    "https://www.youtube.com/watch?v=YcQ8g9bXGmA"),
                _buildTipCard(
                    Icons.school,
                    "Community Education",
                    "Educate your family and community about the importance of waste segregation.",
                    Colors.indigo[700]!,
                    "https://www.youtube.com/watch?v=Z5bYkXkQmXU"),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPolicyCard(String text, String url) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.teal[700]!, width: 1),
      ),
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.gavel, size: 32, color: Colors.teal[700]),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    text,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[800],
                    ),
                  ),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: () => _launchURL(url),
                    child: Text(
                      url,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.blue[700],
                        decoration: TextDecoration.underline,
                      ),
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

  Widget _buildTipCard(IconData icon, String title, String description,
      Color color, String? url) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          if (url != null) {
            _launchURL(url);
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: color.withOpacity(0.3)),
                ),
                child: Icon(icon, size: 24, color: color),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[700],
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 8),
                    if (url != null)
                      Text(
                        "Link: $url",
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.blue[700],
                          decoration: TextDecoration.underline,
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
