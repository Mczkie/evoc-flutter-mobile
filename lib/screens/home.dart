// ignore_for_file: unused_field, unnecessary_cast, unused_element
import 'package:flutter/material.dart';
import 'package:evocapp/database/db_helper.dart';
import 'package:evocapp/screens/startup.dart';
import 'package:evocapp/screens/eventDate.dart';

class MyHome extends StatefulWidget {
  final String email;

  const MyHome({super.key, required this.email});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  final DbHelper _dbHelper = DbHelper();
  bool _isLoggedIn = false;
  Map<DateTime, String> _eventDates = {};

  // Updated Color Palette - Eco-friendly Nature Theme
  static const Color primaryColor = Color(0xFF388E3C); // Deeper green
  static const Color secondaryColor = Color(0xFF689F38); // Leaf green
  static const Color accentColor = Color(0xFF7CB342); // Fresh green
  static const Color background = Color(0xFFF5FBF6); // Very light green
  static const Color cardColor = Colors.white;
  static const Color textDark = Color(0xFF2E3A3A); // Dark teal
  static const Color textLight = Color(0xFF6B7A7A); // Medium teal

// Updated Category Colors
  static const Map<String, Color> categoryColors = {
    'Cardboard': Color(0xFF795548), // Brown
    'Glass': Color(0xFF4FC3F7), // Light blue
    'Metal': Color(0xFF78909C), // Blue gray
    'Paper': Color(0xFFFFD54F), // Amber
    'Plastic': Color(0xFFBA68C8), // Purple
    'General Waste': Color(0xFF90A4AE), // Light gray
  };
  // Recycling Items
  final List<Map<String, String>> recyclingItems = [
    {
      'image': 'assets/cardboard_167.jpg',
      'title': 'Cardboard',
      'description':
          'Cardboard waste includes used boxes, packaging materials, and paperboard products. It is highly recyclable and can be processed to create new cardboard items. Recycling cardboard reduces deforestation and minimizes landfill buildup, making it an eco-friendly option for packaging disposal.',
    },
    {
      'image': 'assets/glass_001.jpg',
      'title': 'Glass',
      'description':
          'Glass waste refers to discarded glass materials that are no longer useful in their original form. This includes broken bottles, jars, windows, and other glass products. Unlike many other materials, glass is 100% recyclable and can be reused endlessly without losing its quality or purity. Proper disposal and recycling of glass waste help conserve natural resources, reduce landfill use, and lower energy consumption in the production of new glass products.',
    },
    {
      'image': 'assets/metal_200.jpg',
      'title': 'Metal',
      'description':
          'Metal waste consists of discarded metal items like cans, tins, tools, and scrap metal. Metals are valuable materials that can be recycled repeatedly without losing strength or quality. Recycling metal helps conserve raw materials, save energy, and reduce environmental pollution.',
    },
    {
      'image': 'assets/paper_184.jpg',
      'title': 'Paper',
      'description':
          'Paper waste includes used or unwanted paper products such as newspapers, magazines, office paper, and books. It is biodegradable and recyclable. Recycling paper reduces the need for virgin pulp, conserves water and energy, and helps prevent excessive waste in landfills.',
    },
    {
      'image': 'assets/plastic_076.jpg',
      'title': 'Plastic',
      'description':
          'Plastic waste is made up of items like bottles, containers, bags, and packaging materials. It is one of the most common types of waste and poses a major environmental challenge due to its slow decomposition. Proper sorting and recycling can help reduce pollution and protect ecosystems.',
    },
    {
      'image': 'assets/trash_005.jpg',
      'title': 'General Waste',
      'description':
          'General waste includes non-recyclable and non-compostable items such as food wrappers, hygiene products, and broken household items. This type of waste usually ends up in landfills or incineration facilities. Reducing general waste involves mindful consumption and better recycling habits.',
    },
  ];

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
    _loadEventDates();
  }

  Future<void> _checkLoginStatus() async {
    final loggedInUser = await _dbHelper.getLoggedInUser();

    // If the user is not logged in, navigate to the Startup page
    if (loggedInUser == null) {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => MyStartup(email: widget.email)),
        );
      }
    } else {
      // If the user is logged in, set the state to logged in and load event dates
      if (mounted) {
        setState(() {
          _isLoggedIn = true;
        });
      }

      // Now load event dates after confirming the user is logged in
      _loadEventDates();
    }
  }

  Future<void> _loadEventDates() async {
    final reports = await _dbHelper.getReports();
    final eventDates = await _dbHelper.getUniqueEventDates();

    final events = <DateTime, String>{};
    for (var date in eventDates) {
      events[date] = 'No description';
    }

    for (var report in reports) {
      final dateStr = report['eventDate'] as String?;
      if (dateStr != null) {
        final date = DateTime.parse(dateStr);
        events[date] = report['note'] as String;
      }
    }

    setState(() => _eventDates = events);
  }

  @override
  Widget build(BuildContext context) {
    if (!_isLoggedIn) {
      return Scaffold(
        backgroundColor: background,
        body: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
          ),
        ),
      );
    }

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: background,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              _buildHeroSection(),
              const SizedBox(height: 24),
              // _buildSearchBar(),
              const SizedBox(height: 24),
              _buildCategoriesSection(),
              const SizedBox(height: 24),

              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Upcoming Events',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: textDark,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              CollectionSchedulePage(),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 1,
      centerTitle: true,
      title: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Eco',
              style: TextStyle(
                color: primaryColor,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextSpan(
              text: 'Vista',
              style: TextStyle(
                color: textDark,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroSection() {
    return Container(
      height: 220,
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Stack(
        children: [
          Opacity(
            opacity: 0.1,
            child: Image.asset(
              'assets/appLogo.png',
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Welcome to',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Eco Vista',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Olongapo City',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 24,
                  ),
                ),
                const SizedBox(height: 16),
                _buildTaglineChip(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTaglineChip() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white.withOpacity(0.4),
          width: 1,
        ),
      ),
      child: const Text(
        'Recycle Today for a Better Tomorrow',
        style: TextStyle(
          color: Colors.white,
          fontSize: 14,
        ),
      ),
    );
  }

  // Widget _buildSearchBar() {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 24),
  //     child: Container(
  //       padding: const EdgeInsets.symmetric(horizontal: 16),
  //       decoration: BoxDecoration(
  //         color: cardColor,
  //         borderRadius: BorderRadius.circular(12),
  //         boxShadow: [
  //           BoxShadow(
  //             color: Colors.black.withOpacity(0.05),
  //             blurRadius: 10,
  //             offset: const Offset(0, 5),
  //           ),
  //         ],
  //       ),
  //       child: const TextField(
  //         decoration: InputDecoration(
  //           hintText: 'Search recycling tips...',
  //           border: InputBorder.none,
  //           icon: Icon(Icons.search, color: textLight),
  //           suffixIcon: Icon(Icons.tune, color: textLight),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget _buildCategoriesSection() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Recycling Categories',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: textDark,
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AllCategoriesScreen(
                      categories: recyclingItems,
                      categoryColors: categoryColors,
                    ),
                  ),
                );
              },
              child: const Text(
                'See All',
                style: TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: recyclingItems.length,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.only(right: 16),
              child: _buildCategoryCard(index),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryCard(int index) {
    final item = recyclingItems[index];
    final color = categoryColors[item['title']] ?? accentColor;

    return GestureDetector(
      onTap: () => _showCategoryDetails(item),
      child: Container(
        width: 200,
        margin: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.3),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              Image.asset(
                item['image']!,
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      color.withOpacity(0.7),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 16,
                left: 16,
                right: 16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['title']!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item['description']!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 12,
                right: 12,
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.arrow_forward,
                    color: color,
                    size: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showCategoryDetails(Map<String, String> item) {
    final color = categoryColors[item['title']] ?? accentColor;

    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(16)),
                    child: Image.asset(
                      item['image']!,
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 16,
                    right: 16,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.9),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.recycling,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['title']!,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: textDark,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      item['description']!,
                      style: const TextStyle(
                        fontSize: 16,
                        color: textLight,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Recycling Tips:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: textDark,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _getRecyclingTips(item['title']!),
                      style: const TextStyle(
                        fontSize: 14,
                        color: textLight,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEventSummaryItem(int index) {
    final date = _eventDates.keys.elementAt(index);
    final description = _eventDates[date]!;

    return ListTile(
      leading: Icon(Icons.event, color: primaryColor),
      title: Text(
        description,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        '${date.toLocal().toString().split(' ')[0]} at ${_getFormattedTime(date)}',
      ),
    );
  }

  String _getRecyclingTips(String category) {
    switch (category) {
      case 'Cardboard':
        return '• Flatten boxes to save space\n• Remove all tape and labels\n• Keep dry and clean\n• Pizza boxes with grease go in compost';
      case 'Glass':
        return '• Rinse containers thoroughly\n• Remove metal lids and caps\n• Separate by color if required\n• Broken glass should be wrapped';
      case 'Metal':
        return '• Rinse cans to remove food\n• Aluminum and steel are both recyclable\n• Remove plastic labels if possible\n• Metal can be recycled indefinitely';
      case 'Paper':
        return '• Keep paper clean and dry\n• Remove plastic windows from envelopes\n• Shredded paper should be bagged\n• Can be recycled 5-7 times';
      case 'Plastic':
        return '• Check the resin number (1-7)\n• Rinse containers thoroughly\n• Remove caps and pumps\n• Flatten bottles to save space';
      case 'General Waste':
        return '• Try to minimize waste\n• Consider composting organics\n• Hazardous materials need special disposal\n• When in doubt, check guidelines';
      default:
        return 'Check local recycling guidelines for proper disposal methods.';
    }
  }

  String _getMonthAbbreviation(int month) {
    return [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ][month - 1];
  }

  String _getFormattedTime(DateTime date) {
    return '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }
}

class AllCategoriesScreen extends StatelessWidget {
  final List<Map<String, String>> categories;
  final Map<String, Color> categoryColors;

  const AllCategoriesScreen({
    super.key,
    required this.categories,
    required this.categoryColors,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Recycling Categories'),
        backgroundColor: _MyHomeState.primaryColor,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final item = categories[index];
          final color =
              categoryColors[item['title']] ?? _MyHomeState.accentColor;

          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: InkWell(
              onTap: () {
                _showCategoryDetails(context, item, color);
              },
              borderRadius: BorderRadius.circular(12),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        item['image']!,
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item['title']!,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: _MyHomeState.textDark,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            item['description']!,
                            style: const TextStyle(
                              fontSize: 14,
                              color: _MyHomeState.textLight,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.chevron_right,
                      color: color,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _showCategoryDetails(
      BuildContext context, Map<String, String> item, Color color) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(16)),
                    child: Image.asset(
                      item['image']!,
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 16,
                    right: 16,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.9),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.recycling,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['title']!,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: _MyHomeState.textDark,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      item['description']!,
                      style: const TextStyle(
                        fontSize: 16,
                        color: _MyHomeState.textLight,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Recycling Tips:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: _MyHomeState.textDark,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _getRecyclingTips(item['title']!),
                      style: const TextStyle(
                        fontSize: 14,
                        color: _MyHomeState.textLight,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getRecyclingTips(String category) {
    switch (category) {
      case 'Cardboard':
        return '• Flatten boxes to save space\n• Remove all tape and labels\n• Keep dry and clean\n• Pizza boxes with grease go in compost';
      case 'Glass':
        return '• Rinse containers thoroughly\n• Remove metal lids and caps\n• Separate by color if required\n• Broken glass should be wrapped';
      case 'Metal':
        return '• Rinse cans to remove food\n• Aluminum and steel are both recyclable\n• Remove plastic labels if possible\n• Metal can be recycled indefinitely';
      case 'Paper':
        return '• Keep paper clean and dry\n• Remove plastic windows from envelopes\n• Shredded paper should be bagged\n• Can be recycled 5-7 times';
      case 'Plastic':
        return '• Check the resin number (1-7)\n• Rinse containers thoroughly\n• Remove caps and pumps\n• Flatten bottles to save space';
      case 'General Waste':
        return '• Try to minimize waste\n• Consider composting organics\n• Hazardous materials need special disposal\n• When in doubt, check guidelines';
      default:
        return 'Check local recycling guidelines for proper disposal methods.';
    }
  }
}
