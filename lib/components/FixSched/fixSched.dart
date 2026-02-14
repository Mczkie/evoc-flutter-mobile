import 'package:flutter/material.dart';

class FixedSched extends StatelessWidget {
  const FixedSched({super.key});

  final List<Map<String, String>> fixedSchedules = const [
    {
      'barangay': 'Barangay East Bajac-Bajac',
      'schedule': 'Every Monday & Thursday',
    },
    {
      'barangay': 'Barangay West Bajac-Bajac',
      'schedule': 'Every Tuesday',
    },
    {
      'barangay': 'Barangay Pag-Asa',
      'schedule': 'Every Wednesday & Saturday',
    },
    {
      'barangay': 'Barangay Banicain',
      'schedule': 'Every Friday',
    },
    {
      'barangay': 'Barangay Mabayuan',
      'schedule': 'Every Thursday & Friday',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '📅 Fixed Collection Schedule',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: fixedSchedules.length,
            itemBuilder: (context, index) {
              final sched = fixedSchedules[index];
              return Card(
                elevation: 0,
                color: Colors.green.shade50,
                margin: const EdgeInsets.symmetric(vertical: 6),
                child: ListTile(
                  leading: const Icon(Icons.location_city, color: Colors.green),
                  title: Text(
                    sched['barangay']!,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text(
                    sched['schedule']!,
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
