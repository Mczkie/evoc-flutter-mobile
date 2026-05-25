class Announcement {
  final int id;
  final String title;
  final String description;
  final String date;
  final String? image;

  Announcement({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    this.image,
  });

  factory Announcement.fromJson(Map<String, dynamic> json) {
    return Announcement(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      date: json['date'] ?? '',
      image: json['image'],
    );
  }
}
