import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';

class NormalTips extends StatelessWidget {
  const NormalTips({super.key});

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);

    if (!await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception(
        "Could not launch $url",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.green.shade700,
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const Text(
          "Eco Tips",
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
              /// HERO CARD
              Container(
                height: 280,
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(28),
                  gradient: LinearGradient(
                    colors: [
                      Colors.green.shade800,
                      Colors.green.shade500,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      right: -20,
                      bottom: -20,
                      child: Opacity(
                        opacity: .15,
                        child: Icon(
                          Icons.recycling,
                          size: 180,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(.2),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.eco,
                            color: Colors.white,
                            size: 35,
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          "Live Green,\nSave Earth",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          "Simple environmental tips to help protect nature and keep communities clean.",
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

              const SizedBox(height: 25),

              /// POLICY CARD
              _buildPolicyCard(
                "DM No. 268, s. 2023 – STRICT IMPLEMENTATION OF NO SEGREGATION, NO COLLECTION OF GARBAGE POLICY WITHIN OLONGAPO CITY",
                "https://deped-olongapo.com/dm-no-268-s-2023-strict-emplementation-of-no-segregation-no-collection-of-garbage-policy-within-olongapo-city/",
                _launchURL,
              ),

              const SizedBox(height: 25),

              /// TITLE
              const Text(
                "Daily Eco Habits",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 18),

              /// CARDS
              _buildTipCard(
                Icons.recycling,
                "Practice Waste Segregation",
                "Separate biodegradable and non-biodegradable waste properly to help recycling centers process garbage efficiently.",
                Colors.green,
                "assets/videos/Video-1.mp4",
              ),

              _buildTipCard(
                Icons.water_drop,
                "Save Water",
                "Turn off faucets when not in use and avoid wasting clean water at home or school.",
                Colors.blue,
                "assets/videos/Video-2.mp4",
              ),

              _buildTipCard(
                Icons.energy_savings_leaf,
                "Conserve Electricity",
                "Switch off lights, fans, and appliances when not being used to save energy.",
                Colors.orange,
                "assets/videos/Video-3.mp4",
              ),

              _buildTipCard(
                Icons.shopping_bag,
                "Use Reusable Items",
                "Use eco bags, tumblers, and reusable containers instead of single-use plastics.",
                Colors.purple,
                "assets/videos/Video-5.mp4",
              ),

              _buildTipCard(
                Icons.park,
                "Plant Trees",
                "Trees help clean the air, reduce heat, and improve the environment.",
                Colors.teal,
                "assets/videos/Video-6.mp4",
              ),

              _buildTipCard(
                Icons.clean_hands,
                "Keep Surroundings Clean",
                "Throw trash properly and encourage others to maintain cleanliness in public places.",
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
  return Container(
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(24),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(.05),
          blurRadius: 10,
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.green.withOpacity(.1),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Environmental Policy",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  text,
                  style: const TextStyle(
                    height: 1.5,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

/// TIP CARD
Widget _buildTipCard(
  IconData icon,
  String title,
  String description,
  Color color,
  String videoPath,
) {
  return Container(
    margin: const EdgeInsets.only(bottom: 20),
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(25),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(.05),
          blurRadius: 10,
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: color,
                size: 28,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 16),

        Text(
          description,
          style: const TextStyle(
            fontSize: 15,
            height: 1.6,
          ),
          textAlign: TextAlign.justify,
        ),

        const SizedBox(height: 18),

        /// VIDEO
        AssetVideoPlayer(
          videoPath: videoPath,
        ),
      ],
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
          borderRadius: BorderRadius.circular(18),
          child: AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: VideoPlayer(
              _controller,
            ),
          ),
        ),
        const SizedBox(height: 8),
        IconButton(
          icon: Icon(
            _controller.value.isPlaying
                ? Icons.pause_circle
                : Icons.play_circle,
            size: 40,
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
