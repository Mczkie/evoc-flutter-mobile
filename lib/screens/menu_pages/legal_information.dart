import 'package:evocapp/screens/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyInformation());
}

class MyInformation extends StatefulWidget {
  const MyInformation({super.key});

  @override
  State<MyInformation> createState() => _MyInformationState();
}

class _MyInformationState extends State<MyInformation> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Legal Information',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const LegalInformationScreen(),
    );
  }
}

class LegalInformationScreen extends StatelessWidget {
  const LegalInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Legal Information'),
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
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Terms and Conditions',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              _buildLegalCard(
                title: '1. Acceptance of Terms',
                content:
                    'By using this application, you agree to comply with and be bound by these terms and conditions. If you do not agree, please do not use the application.',
              ),
              const SizedBox(height: 16),
              _buildLegalCard(
                title: '2. Privacy Policy',
                content:
                    'We respect your privacy. All personal information collected through this application will be used solely for the purpose of improving your experience and will not be shared with third parties without your consent.',
              ),
              const SizedBox(height: 16),
              _buildLegalCard(
                title: '3. User Responsibilities',
                content:
                    'You are responsible for ensuring that the information you provide is accurate and up-to-date. Misuse of the application may result in termination of access.',
              ),
              const SizedBox(height: 16),
              _buildLegalCard(
                title: '4. Intellectual Property',
                content:
                    'All content, logos, and designs in this application are the property of EcoVista and are protected by intellectual property laws. Unauthorized use is prohibited.',
              ),
              const SizedBox(height: 16),
              _buildLegalCard(
                title: '5. Limitation of Liability',
                content:
                    'EcoVista is not liable for any damages arising from the use of this application. We strive to provide accurate information, but we do not guarantee its completeness or accuracy.',
              ),
              const SizedBox(height: 16),
              _buildLegalCard(
                title: '6. Governing Law',
                content:
                    'These terms and conditions are governed by the laws of the State of California. Any disputes will be resolved in the courts of California.',
              ),
              const SizedBox(height: 16),
              _buildLegalCard(
                title: '7. Changes to Terms',
                content:
                    'We reserve the right to modify these terms and conditions at any time. Continued use of the application constitutes acceptance of the updated terms.',
              ),
              const SizedBox(height: 16),
              const Text(
                'Contact Us',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              _buildLegalCard(
                title: 'Email',
                content: 'support@ecovista.com',
              ),
              const SizedBox(height: 16),
              _buildLegalCard(
                title: 'Phone',
                content: '+1 (123) 456-7890',
              ),
              const SizedBox(height: 16),
              _buildLegalCard(
                title: 'Address',
                content: 'Olongapo City, Zambales',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLegalCard({required String title, required String content}) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              content,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
