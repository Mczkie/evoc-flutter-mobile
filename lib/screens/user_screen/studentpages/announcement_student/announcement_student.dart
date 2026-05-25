import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

// 👇 IMPORT YOUR MODEL HERE
import 'package:evocapp/models/announcement.dart';

class AnnouncementStudent extends StatefulWidget {
  const AnnouncementStudent({super.key});

  @override
  State<AnnouncementStudent> createState() => _AnnouncementStudentState();
}

class _AnnouncementStudentState extends State<AnnouncementStudent> {
  List<Announcement> announcements = [];
  bool isLoading = false;

  int unreadCount = 0;
  int lastSeenId = 0;

  @override
  void initState() {
    super.initState();
    loadLastSeen();
    fetchAnnouncements();
  }

  Future<void> loadLastSeen() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      lastSeenId = prefs.getInt("lastSeenAnnouncement") ?? 0;
    });
  }

  Future<void> fetchAnnouncements() async {
    try {
      setState(() => isLoading = true);

      final response = await http.get(
        Uri.parse("https://evoc-backend.onrender.com/api/announcement"),
      );

      if (response.statusCode == 200) {
        final List data = jsonDecode(response.body);

        List<Announcement> loaded =
            data.map((json) => Announcement.fromJson(json)).toList();

        setState(() {
          announcements = loaded;

          unreadCount = loaded.where((a) => a.id > lastSeenId).length;

          isLoading = false;
        });
      } else {
        setState(() => isLoading = false);
      }
    } catch (e) {
      setState(() => isLoading = false);
    }
  }

  Future<void> markAllAsRead() async {
    final prefs = await SharedPreferences.getInstance();

    if (announcements.isNotEmpty) {
      await prefs.setInt(
        "lastSeenAnnouncement",
        announcements.first.id,
      );

      setState(() {
        unreadCount = 0;
        lastSeenId = announcements.first.id;
      });
    }
  }

  bool isNewAnnouncement(String timestamp) {
    try {
      final normalized = timestamp.replaceAll(' ', 'T');
      final announcementTime = DateTime.parse(normalized);
      final now = DateTime.now();

      return now.difference(announcementTime).inSeconds <= 120;
    } catch (e) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5FBF6),
      appBar: AppBar(
        title: const Text("Announcements"),
        backgroundColor: Colors.white,
        elevation: 1,
        foregroundColor: Colors.black,
      ),
      body: RefreshIndicator(
        onRefresh: fetchAnnouncements,
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : announcements.isEmpty
                ? _emptyState()
                : ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: announcements.length,
                    itemBuilder: (context, index) {
                      final item = announcements[index];
                      return _announcementCard(item);
                    },
                  ),
      ),
    );
  }

  // EMPTY STATE
  Widget _emptyState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.notifications_off,
            size: 60,
            color: Colors.grey,
          ),
          SizedBox(height: 10),
          Text(
            "No announcements yet",
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  // CARD UI
  Widget _announcementCard(Announcement item) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // TITLE + BADGE
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    item.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green.shade100,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    isNewAnnouncement(item.date) ? "NEW" : "RECENT",
                    style: TextStyle(
                      fontSize: 10,
                      color: isNewAnnouncement(item.date)
                          ? Colors.green
                          : Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            Text(
              item.description,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black87,
              ),
            ),

            if (item.image != null)
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    "https://evoc-backend.onrender.com${item.image}",
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Text(
                        "Image failed to load",
                        style: TextStyle(color: Colors.red),
                      );
                    },
                  ),
                ),
              ),

            const SizedBox(height: 10),

            Row(
              children: [
                const Icon(
                  Icons.calendar_today,
                  size: 14,
                  color: Colors.grey,
                ),
                const SizedBox(width: 5),
                Text(
                  item.date,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
