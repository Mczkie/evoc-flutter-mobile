import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';

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
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
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
                    colors: [
                      Colors.green.shade700,
                      Colors.green.shade400,
                    ],
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
                          "Educational content for students about waste segregation, recycling, and environmental awareness.",
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

              /// EDUCATIONAL POLICY
              _buildPolicyCard(
                "DM No. 268, s. 2023 – STRICT IMPLEMENTATION OF NO SEGREGATION, NO COLLECTION OF GARBAGE POLICY WITHIN OLONGAPO CITY",
                "https://deped-olongapo.com/dm-no-268-s-2023-strict-emplementation-of-no-segregation-no-collection-of-garbage-policy-within-olongapo-city/",
                _launchURL,
              ),

              const SizedBox(height: 10),

              /// SECTION TITLE
              const Text(
                "Educational Topics",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 15),

              /// EDUCATIONAL CONTENTS
              _buildTipCard(
                Icons.recycling,
                "What is Waste Segregation?",
                "Waste segregation is the process of separating biodegradable and non-biodegradable waste to reduce pollution and improve recycling efficiency.",
                Colors.green,
                "assets/videos/Video-1.mp4",
              ),

              _buildTipCard(
                Icons.delete,
                "Proper Disposal",
                "Always throw waste into the correct bins to maintain cleanliness and protect the environment.",
                Colors.orange,
                "assets/videos/Video-2.mp4",
              ),

              _buildTipCard(
                Icons.eco,
                "Environmental Awareness",
                "Students can help the environment by practicing proper waste management and reducing plastic use.",
                Colors.teal,
                "assets/videos/Video-3.mp4",
              ),

              _buildTipCard(
                Icons.clean_hands,
                "Clean Surroundings",
                "Keeping your surroundings clean helps prevent diseases and keeps communities safe.",
                Colors.blue,
                "assets/videos/Video-5.mp4",
              ),

              _buildTipCard(
                Icons.shopping_bag,
                "Reduce Plastic Usage",
                "Use reusable bags, tumblers, and eco-friendly materials instead of single-use plastics.",
                Colors.purple,
                "assets/videos/Video-6.mp4",
              ),

              _buildTipCard(
                Icons.school,
                "Student Responsibility",
                "Students play an important role in protecting nature by becoming responsible and environmentally aware citizens.",
                Colors.red,
                "assets/videos/Video-7.mp4",
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// POLICY CARD
Widget _buildPolicyCard(
  String text,
  String url,
  Function(String) launchURL,
) {
  return Card(
    elevation: 2,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(18),
    ),
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.gavel,
              color: Colors.green,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: GestureDetector(
              onTap: () => launchURL(url),
              child: Text(
                text,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

/// EDUCATIONAL CARD
Widget _buildTipCard(
  IconData icon,
  String title,
  String description,
  Color color,
  String videoPath,
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
                child: Icon(
                  icon,
                  color: color,
                ),
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
              height: 1.5,
              fontSize: 15,
            ),
            textAlign: TextAlign.justify,
          ),
          const SizedBox(height: 15),
          AssetVideoPlayer(
            videoPath: videoPath,
          ),
        ],
      ),
    ),
  );
}

/// VIDEO PLAYER
class AssetVideoPlayer extends StatefulWidget {
  final String videoPath;

  const AssetVideoPlayer({
    super.key,
    required this.videoPath,
  });

  @override
  State<AssetVideoPlayer> createState() => _AssetVideoPlayerState();
}

class _AssetVideoPlayerState extends State<AssetVideoPlayer> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.asset(
      widget.videoPath,
    )..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_controller.value.isInitialized) {
      return const SizedBox(
        height: 200,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: VideoPlayer(_controller),
          ),
        ),
        IconButton(
          icon: Icon(
            _controller.value.isPlaying
                ? Icons.pause_circle
                : Icons.play_circle,
            size: 35,
            color: Colors.green,
          ),
          onPressed: () {
            setState(() {
              _controller.value.isPlaying
                  ? _controller.pause()
                  : _controller.play();
            });
          },
        ),
      ],
    );
  }
}
