import 'package:flutter/material.dart';

class RecycleTitle extends StatelessWidget {
  const RecycleTitle({
    super.key,
    required this.recyclingTips,
  });

  final List<Map<String, String>> recyclingTips;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // TITLE
        const Text(
          'Types of Recycling',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),

        // SEE ALL BUTTON
        ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text(
                    'All Recycling Tips',
                  ),
                  content: SizedBox(
                    height: 400,
                    width: double.maxFinite,
                    child: ListView.builder(
                      itemCount: recyclingTips.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.only(
                            bottom: 12,
                          ),
                          padding: const EdgeInsets.all(
                            12,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.green.shade50,
                            borderRadius: BorderRadius.circular(
                              12,
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // ICON
                              const Icon(
                                Icons.recycling,
                                color: Colors.green,
                              ),

                              const SizedBox(
                                width: 10,
                              ),

                              // TEXT
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      recyclingTips[index]["title"]!,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      recyclingTips[index]["tip"]!,
                                      textAlign: TextAlign.justify,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Close'),
                    ),
                  ],
                );
              },
            );
          },
          child: const Text('See All'),
        ),
      ],
    );
  }
}
