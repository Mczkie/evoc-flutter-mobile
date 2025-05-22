import 'dart:io';
import 'package:flutter/material.dart';

class MyResult extends StatelessWidget {
  final File image;
  final String result;
  final String objectType;

  const MyResult({
    super.key,
    required this.image,
    required this.result,
    required this.objectType,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.grey.shade50,
              Colors.grey.shade100,
            ],
          ),
        ),
        child: Column(
          children: [
            _buildAppBar(context),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    _buildImagePreview(),
                    const SizedBox(height: 32),
                    _buildResultCard(),
                    const SizedBox(height: 40),
                    _buildActionButton(context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            IconButton(
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.arrow_back_ios_new_rounded,
                    size: 20, color: Colors.grey.shade800),
              ),
              onPressed: () => Navigator.pop(context),
            ),
            const SizedBox(width: 16),
            Text('Scan Result',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade900,
                )),
            const Spacer(),
            IconButton(
              icon: Icon(Icons.share_rounded, color: Colors.grey.shade800),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImagePreview() {
    return FutureBuilder<File>(
      future: Future.value(image),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildImagePlaceholder();
        }
        if (snapshot.hasError || !snapshot.hasData) {
          return _buildImageError();
        }
        return _buildImageContent(snapshot.data!);
      },
    );
  }

  Widget _buildImageContent(File imageFile) {
    return Container(
      width: 280,
      height: 280,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 16,
            spreadRadius: 4,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Image.file(
          imageFile,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => _buildImageError(),
        ),
      ),
    );
  }

  Widget _buildImagePlaceholder() {
    return Container(
      width: 280,
      height: 280,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Center(
        child: CircularProgressIndicator(
          color: Colors.grey.shade400,
          strokeWidth: 2,
        ),
      ),
    );
  }

  Widget _buildImageError() {
    return Container(
      width: 280,
      height: 280,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Center(
        child: Icon(
          Icons.broken_image_rounded,
          size: 48,
          color: Colors.grey.shade400,
        ),
      ),
    );
  }

  Widget _buildResultCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 16,
            spreadRadius: 4,
          ),
        ],
      ),
      child: Column(
        children: [
          _buildResultItem('Category', result),
          const SizedBox(height: 16),
          _buildResultItem('Waste Type', objectType),
        ],
      ),
    );
  }

  Widget _buildResultItem(String title, String value) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  )),
              const SizedBox(height: 4),
              Text(value,
                  style: TextStyle(
                    color: Colors.grey.shade900,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  )),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: _getTypeColor(objectType).withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            _getTypeIcon(objectType),
            color: _getTypeColor(objectType),
            size: 24,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => Navigator.pop(context),
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 32),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.blue.shade600,
                Colors.blue.shade400,
              ],
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.blue.shade200,
                blurRadius: 16,
                spreadRadius: 4,
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.recycling_rounded, color: Colors.white),
              const SizedBox(width: 12),
              const Text(
                'New Scan',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getTypeColor(String type) {
    switch (type.toLowerCase()) {
      case 'non-biodegradable':
        return Colors.red.shade600;
      case 'biodegradable':
        return Colors.green.shade600;
      case 'general waste':
        return Colors.orange.shade600;
      default:
        return Colors.grey.shade600;
    }
  }

  IconData _getTypeIcon(String type) {
    switch (type.toLowerCase()) {
      case 'non-biodegradable':
        return Icons.do_not_disturb_on_total_silence_rounded;
      case 'biodegradable':
        return Icons.eco_rounded;
      case 'general waste':
        return Icons.delete_outline_rounded;
      default:
        return Icons.help_outline_rounded;
    }
  }
}
