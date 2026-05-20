import 'package:evocapp/screens/user_screen/studentpages/recycling_tips/recycle_title/recycle_title.dart';
import 'package:flutter/material.dart';

class Recycling extends StatelessWidget {
  Recycling({super.key});

  final List<Map<String, String>> recyclingTips = [
    {
      "title": "Clean Recyclables",
      "tip": "Rinse and clean recyclables to prevent contamination.",
      "image": "images/studentHome/header.png",
    },
    {
      "title": "Flatten Boxes",
      "tip": "Flatten cardboard boxes to save space in recycling bins.",
      "image": "images/studentHome/header.png",
    },
    {
      "title": "Know The Rules",
      "tip": "Check local recycling guidelines for specific items.",
      "image": "images/studentHome/header.png",
    },
    {
      "title": "Avoid Contamination",
      "tip": "Avoid placing non-recyclable items in recycling bins.",
      "image": "images/studentHome/header.png",
    },
    {
      "title": "Reuse First",
      "tip": "Reuse or repurpose items before recycling them.",
      "image": "images/studentHome/header.png",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // TITLE
        RecycleTitle(
          recyclingTips: recyclingTips,
        ),

        const SizedBox(height: 10),

        // HORIZONTAL CARD LIST
        SizedBox(
          height: 268,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: recyclingTips.length,
            itemBuilder: (context, index) {
              return Container(
                width: 300,
                margin: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 17,
                ),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  image: DecorationImage(
                    image: AssetImage(
                      recyclingTips[index]["image"]!,
                    ),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.45),
                      BlendMode.darken,
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ICON
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.25),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.recycling,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),

                    const SizedBox(height: 10),

                    // TITLE
                    Text(
                      recyclingTips[index]["title"]!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    // SUBTITLE
                    const Text(
                      "Help protect our environment",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),

                    // TIP CONTAINER
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.92),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        recyclingTips[index]["tip"]!,
                        textAlign: TextAlign.justify,
                        style: const TextStyle(
                          fontSize: 16,
                          height: 1.5,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
