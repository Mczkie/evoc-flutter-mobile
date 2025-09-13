import 'package:evocapp/screens/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyFAQS());
}

class MyFAQS extends StatelessWidget {
  const MyFAQS({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Waste Segregation FAQs',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const WasteSegregationFAQsScreen(),
    );
  }
}

class WasteSegregationFAQsScreen extends StatelessWidget {
  const WasteSegregationFAQsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Waste Segregation FAQs'),
        centerTitle: true,
        backgroundColor: Colors.green,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => MyHomePage(email: ''))),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.green, Colors.lightGreen],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: const [
            FAQItem(
              question: 'What is waste segregation?',
              answer:
                  'Waste segregation is the process of separating waste into different categories such as biodegradable, non-biodegradable, recyclable, and hazardous waste. This helps in proper disposal and recycling.',
            ),
            FAQItem(
              question: 'Why is waste segregation important?',
              answer:
                  'Waste segregation is important because it reduces the amount of waste sent to landfills, promotes recycling, and minimizes environmental pollution. It also helps in the efficient management of resources.',
            ),
            FAQItem(
              question: 'How do I segregate waste at home?',
              answer:
                  'To segregate waste at home, use separate bins for different types of waste:\n'
                  '- Green bin for biodegradable waste (e.g., food scraps, garden waste).\n'
                  '- Blue bin for recyclable waste (e.g., paper, plastic, metal).\n'
                  '- Red bin for hazardous waste (e.g., batteries, chemicals).',
            ),
            FAQItem(
              question: 'What is biodegradable waste?',
              answer:
                  'Biodegradable waste includes organic materials that can be broken down by microorganisms, such as food waste, vegetable peels, and garden waste. This type of waste can be composted.',
            ),
            FAQItem(
              question: 'What is non-biodegradable waste?',
              answer:
                  'Non-biodegradable waste includes materials that cannot be broken down by natural processes, such as plastic, glass, and metal. These materials should be recycled or disposed of properly.',
            ),
            FAQItem(
              question: 'Can I recycle plastic bags?',
              answer:
                  'Yes, plastic bags can be recycled, but they should be clean and dry. Many grocery stores have collection bins for plastic bags. Avoid throwing them in regular recycling bins as they can clog machinery.',
            ),
            FAQItem(
              question: 'What should I do with electronic waste?',
              answer:
                  'Electronic waste (e-waste) should be taken to designated e-waste recycling centers. Do not dispose of it in regular trash as it contains hazardous materials like lead and mercury.',
            ),
          ],
        ),
      ),
    );
  }
}

class FAQItem extends StatefulWidget {
  final String question;
  final String answer;

  const FAQItem({
    super.key,
    required this.question,
    required this.answer,
  });

  @override
  State<FAQItem> createState() => _FAQItemState();
}

class _FAQItemState extends State<FAQItem> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          setState(() {
            _isExpanded = !_isExpanded;
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      widget.question,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ),
                  Icon(
                    _isExpanded ? Icons.expand_less : Icons.expand_more,
                    color: Colors.green,
                  ),
                ],
              ),
              if (_isExpanded)
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text(
                    widget.answer,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
