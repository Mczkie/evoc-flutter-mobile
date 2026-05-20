import 'dart:io';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class MyResult extends StatefulWidget {
  final File image;
  final String result;
  final String objectType;

  const MyResult({
    Key? key,
    required this.image,
    required this.result,
    required this.objectType,
  }) : super(key: key);

  @override
  State<MyResult> createState() => _MyResultState();
}

class _MyResultState extends State<MyResult> {
  late VideoPlayerController _controller;

  bool _isVideoInitialized = false;

  late String _description;
  late String _title;

  @override
  void initState() {
    super.initState();

    bool isBio = widget.objectType.toLowerCase() == "biodegradable";

    String videoPath =
        isBio ? "assets/videos/bio.mp4" : "assets/videos/non-bio.mp4";

    _description = isBio
        ? "Biodegradable waste can naturally decompose through microorganisms and helps create compost for the environment."
        : "Non-biodegradable waste does not easily decompose and may remain in the environment for many years.";

    _title = isBio ? "Biodegradable Waste" : "Non-Biodegradable Waste";

    _controller = VideoPlayerController.asset(
      videoPath,
    )..initialize().then((_) {
        setState(() {
          _isVideoInitialized = true;
        });
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Column(
          children: [
            /// APP BAR
            _buildAppBar(context),

            /// BODY
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    /// IMAGE
                    _buildImagePreview(),

                    const SizedBox(height: 25),

                    /// RESULT CARD
                    _buildResultCard(),

                    const SizedBox(height: 25),

                    /// VIDEO
                    _buildVideoPlayer(),

                    const SizedBox(height: 25),

                    /// DESCRIPTION
                    _buildDescription(),

                    const SizedBox(height: 25),

                    /// TITLE
                    _buildTitle(),

                    const SizedBox(height: 25),

                    /// INFOGRAPHIC
                    _buildWasteDescription(),

                    const SizedBox(height: 35),

                    /// BUTTON
                    _buildActionButton(context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// APP BAR
  Widget _buildAppBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 10,
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
            ),
          ),
          const SizedBox(width: 10),
          const Text(
            "Scan Result",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  /// IMAGE PREVIEW
  Widget _buildImagePreview() {
    return Container(
      width: 280,
      height: 280,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.1),
            blurRadius: 15,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: Image.file(
          widget.image,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  /// RESULT CARD
  Widget _buildResultCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 10,
          )
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Waste Type",
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  widget.objectType,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            _getTypeIcon(widget.objectType),
            color: _getTypeColor(widget.objectType),
            size: 35,
          ),
        ],
      ),
    );
  }

  /// VIDEO PLAYER
  Widget _buildVideoPlayer() {
    if (!_isVideoInitialized) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Column(
      children: [
        const Text(
          "Learn More",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
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

  /// DESCRIPTION
  Widget _buildDescription() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 10,
          ),
        ],
      ),
      child: Text(
        _description,
        style: const TextStyle(
          fontSize: 16,
          height: 1.5,
        ),
        textAlign: TextAlign.justify,
      ),
    );
  }

  /// TITLE
  Widget _buildTitle() {
    return Text(
      _title,
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  /// INFOGRAPHIC CONTENT
  Widget _buildWasteDescription() {
    bool isBio = widget.objectType.toLowerCase() == "biodegradable";

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 12,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// HEADER
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: isBio
                      ? Colors.green.withOpacity(.15)
                      : Colors.red.withOpacity(.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isBio ? Icons.eco : Icons.delete,
                  color: isBio ? Colors.green : Colors.red,
                  size: 30,
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Text(
                  isBio
                      ? "Biodegradable Waste Guide"
                      : "Non-Biodegradable Waste Guide",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 25),

          /// WHERE TO PUT
          _buildInfoSection(
            title: "Where to Put",
            icon: Icons.check_circle,
            color: Colors.green,
            items: isBio
                ? [
                    "Compost Bin",
                    "Green Waste Bin",
                    "Garden Compost Area",
                  ]
                : [
                    "Recycling Bin",
                    "Plastic Collection Bin",
                    "E-Waste Collection Area",
                  ],
          ),

          const SizedBox(height: 20),

          /// EXAMPLES
          _buildInfoSection(
            title: "Examples",
            icon: Icons.recycling,
            color: Colors.blue,
            items: isBio
                ? [
                    "Food Scraps",
                    "Fruit Peels",
                    "Vegetables",
                    "Paper",
                    "Leaves",
                  ]
                : [
                    "Plastic Bottles",
                    "Glass",
                    "Cans",
                    "Styrofoam",
                    "Electronics",
                  ],
          ),

          const SizedBox(height: 20),

          /// DO NOT PUT
          _buildInfoSection(
            title: "Do Not Put",
            icon: Icons.cancel,
            color: Colors.red,
            items: isBio
                ? [
                    "Plastic",
                    "Glass",
                    "Metal",
                    "Batteries",
                  ]
                : [
                    "Food Waste",
                    "Wet Garbage",
                    "Leaves",
                    "Organic Waste",
                  ],
          ),
        ],
      ),
    );
  }

  /// INFO SECTION
  Widget _buildInfoSection({
    required String title,
    required IconData icon,
    required Color color,
    required List<String> items,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              icon,
              color: color,
            ),
            const SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ...items.map(
          (item) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    item,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// BUTTON
  Widget _buildActionButton(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 18,
          horizontal: 35,
        ),
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.recycling,
              color: Colors.white,
            ),
            SizedBox(width: 10),
            Text(
              "New Scan",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// COLOR
  Color _getTypeColor(String type) {
    switch (type.toLowerCase()) {
      case "biodegradable":
        return Colors.green;

      case "non-biodegradable":
        return Colors.red;

      default:
        return Colors.grey;
    }
  }

  /// ICON
  IconData _getTypeIcon(String type) {
    switch (type.toLowerCase()) {
      case "biodegradable":
        return Icons.eco;

      case "non-biodegradable":
        return Icons.delete;

      default:
        return Icons.help;
    }
  }
}
