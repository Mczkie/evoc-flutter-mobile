import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MyAnnouncement extends StatefulWidget {
  const MyAnnouncement({super.key});

  @override
  State<MyAnnouncement> createState() => _AnnouncementPageState();
}

class _AnnouncementPageState extends State<MyAnnouncement> {
  List<Map<String, dynamic>> _announcements = [];
  bool _isLoading = false;

  // ⚠️ Change this when testing on real device (use your PC’s IP instead of localhost)
  final String _baseUrl = 'https://evoc-backends.onrender.com/api/announcement';

  @override
  void initState() {
    super.initState();
    _fetchAnnouncements();
  }

  Future<void> _fetchAnnouncements() async {
    setState(() => _isLoading = true);
    try {
      final response = await http.get(Uri.parse(_baseUrl));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _announcements = List<Map<String, dynamic>>.from(data);
        });
      } else {
        throw Exception('Failed to load announcements');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  String _formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      return '${date.day}/${date.month}/${date.year} • ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
    } catch (_) {
      return "Invalid date";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F9F4), // light eco background
      appBar: AppBar(
        title: const Text(
          'Announcements',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.green.shade700,
        elevation: 4,
        centerTitle: true,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(color: Colors.green))
          : RefreshIndicator(
              onRefresh: _fetchAnnouncements,
              color: Colors.green,
              child: _announcements.isEmpty
                  ? const Center(
                      child: Text(
                        '🌱 No announcements yet',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: _announcements.length,
                      itemBuilder: (context, index) {
                        final announcement = _announcements[index];
                        return Card(
                          elevation: 6,
                          margin: const EdgeInsets.only(bottom: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.green.shade50,
                                  Colors.white,
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.green.shade100,
                                      child: const Icon(Icons.campaign,
                                          color: Colors.green),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Text(
                                        announcement['title'] ?? 'No title',
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  announcement['description']?.toString() ??
                                      'No description',
                                  style: const TextStyle(
                                    fontSize: 15,
                                    height: 1.4,
                                    color: Colors.black87,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Row(
                                  children: [
                                    const Icon(Icons.access_time,
                                        size: 16, color: Colors.grey),
                                    const SizedBox(width: 6),
                                    Text(
                                      announcement['time_stamp'] != null
                                          ? _formatDate(
                                              announcement['time_stamp'])
                                          : 'Date not available',
                                      style: const TextStyle(
                                        fontSize: 13,
                                        color: Colors.grey,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
    );
  }
}
