import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MyTips extends StatelessWidget {
  const MyTips({super.key});

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);

    if (!await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception("Could not launch $url");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.green,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Student Education",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// HERO SECTION
              Container(
                height: 220,
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  gradient: LinearGradient(
                    colors: [Colors.green.shade700, Colors.green.shade400],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      right: -10,
                      bottom: -10,
                      child: Opacity(
                        opacity: 0.2,
                        child: Icon(
                          Icons.school,
                          size: 160,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Learning Hub",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Educational content about waste segregation, recycling, and environmental awareness.",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              /// SECTION TITLE
              const Text(
                "Educational Topics",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              _buildPolicyCard(
                "DM No. 268, s. 2023 – STRICT IMPLEMENTATION OF NO SEGREGATION, NO COLLECTION OF GARBAGE POLICY WITHIN OLONGAPO CITY",
                "https://deped-olongapo.com/dm-no-268-s-2023-strict-emplementation-of-no-segregation-no-collection-of-garbage-policy-within-olongapo-city/",
                _launchURL,
              ),

              const SizedBox(height: 15),

              /// CARDS
              _buildTipCard(
                context,
                Icons.recycling,
                "What is Waste Segregation?",
                "Learn how to properly separate biodegradable and non-biodegradable waste to reduce pollution and improve recycling.\n\nCTTO: National Geographic",
                Colors.green,
                "https://www.youtube.com/watch?v=0ZiY6kYReGQ",
              ),

              _buildTipCard(
                context,
                Icons.delete,
                "Proper Disposal",
                "Proper disposal keeps communities clean and safe from diseases.\n\nCTTO: WHO",
                Colors.orange,
                "https://www.youtube.com/watch?v=IMoRFY6hN5Q",
              ),

              _buildTipCard(
                context,
                Icons.eco,
                "Environmental Awareness",
                "Small actions like reducing plastic use can greatly help the environment.\n\nCTTO: TED-Ed",
                Colors.teal,
                "https://www.youtube.com/watch?v=QQYgCxu988s",
              ),

              _buildTipCard(
                context,
                Icons.clean_hands,
                "Clean Surroundings",
                "Clean surroundings prevent diseases and create safer communities.\n\nCTTO: UNICEF",
                Colors.blue,
                "https://www.youtube.com/watch?v=zkqunQY2TnU",
              ),

              _buildTipCard(
                context,
                Icons.shopping_bag,
                "Reduce Plastic Usage",
                "Use reusable bags and avoid single-use plastics.\n\nCTTO: WWF",
                Colors.purple,
                "https://www.youtube.com/watch?v=ODni_Bey154",
              ),

              _buildTipCard(
                context,
                Icons.school,
                "Student Responsibility",
                "Students play a big role in protecting the environment.\n\nCTTO: Environmental Education",
                Colors.red,
                "https://www.youtube.com/watch?v=7V8oFI4GYMY",
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Policy Card
  Widget _buildPolicyCard(
    String title,
    String url,
    Function(String) launchURL,
  ) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: InkWell(
        onTap: () => launchURL(url),
        borderRadius: BorderRadius.circular(18),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.description,
                  color: Colors.green,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ),
              const Icon(Icons.open_in_new, size: 18),
            ],
          ),
        ),
      ),
    );
  }

  /// TIP CARD
  Widget _buildTipCard(
    BuildContext context,
    IconData icon,
    String title,
    String description,
    Color color,
    String youtubeUrl,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: color),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            Text(
              description,
              style: const TextStyle(
                fontSize: 15,
                height: 1.5,
              ),
              textAlign: TextAlign.justify,
            ),

            const SizedBox(height: 12),

            /// YOUTUBE BUTTON
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: color,
              ),
              icon: const Icon(Icons.play_circle, color: Colors.white),
              label: const Text(
                "Watch Video",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                final uri = Uri.parse(youtubeUrl);
                await launchUrl(uri, mode: LaunchMode.externalApplication);
              },
            ),
          ],
        ),
      ),
    );
  }
}
