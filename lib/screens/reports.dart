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

  final String _baseUrl = 'http://192.168.1.249:5000/api/announcement';

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
    final date = DateTime.parse(dateString);
    return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Announcements'),
        backgroundColor: Colors.green,
        elevation: 5,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 20),
                  Expanded(
                    child: _announcements.isEmpty
                        ? const Center(
                            child: Text(
                              'No announcements yet',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey,
                              ),
                            ),
                          )
                        : ListView.builder(
                            itemCount: _announcements.length,
                            itemBuilder: (context, index) {
                              final announcement = _announcements[index];
                              return Card(
                                elevation: 3,
                                margin: const EdgeInsets.symmetric(vertical: 8),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: ListTile(
                                  contentPadding: const EdgeInsets.all(16),
                                  title: Text(
                                    announcement['title'],
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 8),
                                      Text(
                                          announcement['content']?.toString() ??
                                              'No content'),
                                      const SizedBox(height: 8),
                                      Text(
                                        announcement['postedAt'] != null
                                            ? _formatDate(
                                                announcement['postedAt'])
                                            : 'Date not available',
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
