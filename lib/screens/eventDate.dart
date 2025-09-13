import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CollectionSchedulePage extends StatelessWidget {
  const CollectionSchedulePage({super.key});

  Future<List<Map<String, dynamic>>> fetchCollectionSchedules() async {
    final response = await http.get(
      Uri.parse('http://localhost:5001/api/collection'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.cast<Map<String, dynamic>>();
    } else {
      throw Exception('Failed to load schedules');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: fetchCollectionSchedules(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No schedules available'));
        }

        final schedules = snapshot.data!;
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(), // ✅ important
          itemCount: schedules.length,
          itemBuilder: (context, index) {
            final schedule = schedules[index];
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: ListTile(
                leading: const Icon(Icons.event, color: Colors.green),
                title: Text(schedule['date'] ?? 'No Date'),
                subtitle: Text(schedule['location'] ?? 'No Location'),
              ),
            );
          },
        );
      },
    );
  }
}
