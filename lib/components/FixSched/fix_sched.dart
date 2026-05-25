import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class FixedSched extends StatefulWidget {
  const FixedSched({super.key});

  @override
  State<FixedSched> createState() => _FixedSchedState();
}

class _FixedSchedState extends State<FixedSched> {
  List schedules = [];
  bool isLoading = true;

  Future<void> fetchSchedules() async {
    try {
      final response = await http.get(
        Uri.parse("https://evoc-backend.onrender.com/api/fixedschedule"),
      );

      if (response.statusCode == 200) {
        setState(() {
          schedules = json.decode(response.body);
          isLoading = false;
        });
      } else {
        throw Exception("Failed to load schedules");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    fetchSchedules();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(20),
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
            "📅 Collection Schedules",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: schedules.length,
                  itemBuilder: (context, index) {
                    final sched = schedules[index];

                    return Card(
                      elevation: 0,
                      color: Colors.green.shade50,
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      child: ListTile(
                          leading: const Icon(
                            Icons.location_city,
                            color: Colors.green,
                          ),
                          title: Text(
                            sched['barangay']?.toString() ?? "No Barangay",
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                sched['collection_type']?.toString() ??
                                    "No Collection Type",
                                style: const TextStyle(fontSize: 14),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                sched['date'] != null
                                    ? DateFormat('MMMM dd, yyyy').format(
                                        DateTime.parse(sched['date']),
                                      )
                                    : "No Date",
                                style: const TextStyle(fontSize: 14),
                              ),
                              Text(
                                sched['time'] != null
                                    ? DateFormat('hh:mm a').format(
                                        DateFormat("HH:mm:ss")
                                            .parse(sched['time']),
                                      )
                                    : "No Time",
                                style: const TextStyle(fontSize: 14),
                              ),
                            ],
                          )),
                    );
                  },
                ),
        ],
      ),
    );
  }
}
