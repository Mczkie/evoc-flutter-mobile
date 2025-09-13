import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:evocapp/screens/result.dart';
import 'package:tflite_flutter/tflite_flutter.dart' as tfl;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;

class MyScanner extends StatefulWidget {
  const MyScanner({super.key});

  @override
  State<MyScanner> createState() => _MyScannerState();
}

class _MyScannerState extends State<MyScanner> {
  late File _image;
  String? _result;
  String? _objectType;
  List<String>? _labels;
  late tfl.Interpreter? _interpreter;
  final picker = ImagePicker();

  List<String> biowaste = [
    'Food wast',
    'Garden/Plant waste',
    'Paper waste',
    'Agricultural waste',
    'Animal waste',
    'Wood Products',
    'Biodegradable plastics'
  ];

  List<String> nonbiowaste = [
    'Plastic',
    'Metal',
    'Glass',
    'E-waste',
    'Synthetic fabric'
  ];

  @override
  void initState() {
    super.initState();
    loadModel().then((_) {
      loadLabels().then((loadedLabels) {
        setState(() {
          _labels = loadedLabels;
        });
      }).catchError((error) {
        debugPrint('Error loading labels: $error');
      });
    }).catchError((error) {
      debugPrint('Error loading model: $error');
    });
  }

  @override
  void dispose() {
    _interpreter?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
            SafeArea(
              bottom: false,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back_ios_new_rounded,
                          color: Colors.grey.shade800),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    Text('Eco Scan',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.shade900,
                            letterSpacing: 1.1)),
                    IconButton(
                      icon: Icon(Icons.info_outline_rounded,
                          color: Colors.grey.shade800),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Smart Waste\nClassification',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                        color: Colors.grey.shade900,
                        height: 1.2,
                      )),
                  const SizedBox(height: 40),
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(40),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 32,
                          spreadRadius: 8,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade50,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.grey.shade200,
                              width: 2,
                            ),
                          ),
                          child: Stack(
                            children: [
                              Center(
                                child: Icon(Icons.photo_camera_back_rounded,
                                    size: 48, color: Colors.grey.shade400),
                              ),
                              Positioned(
                                bottom: 24,
                                right: 24,
                                child: Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: Colors.blue.shade600,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.blue.shade200,
                                        blurRadius: 16,
                                        spreadRadius: 4,
                                      ),
                                    ],
                                  ),
                                  child: Icon(Icons.spa_rounded,
                                      color: Colors.white, size: 28),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 40),
                        _buildModernButton(
                          icon: Icons.camera_alt_rounded,
                          label: 'Take Photo',
                          color: Colors.blue.shade600,
                          onTap: pickImageFromCamera,
                        ),
                        const SizedBox(height: 16),
                        _buildModernButton(
                          icon: Icons.image_rounded,
                          label: 'Choose from Gallery',
                          color: Colors.grey.shade700,
                          onTap: pickImageFromGallery,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  Center(
                    child: Column(
                      children: [
                        Text('Supported categories: 6 waste types',
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            )),
                        GestureDetector(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text("Waste List"),
                                    content: SizedBox(
                                      height: 150,
                                      child: Center(
                                          child: Column(
                                        children: [
                                          Text('Biodegradable'),
                                          Text(biowaste.toString()),
                                          const SizedBox(height: 10),
                                          Text('Non-Biodegradable'),
                                          Text(nonbiowaste.toString()),
                                        ],
                                      )),
                                    ),
                                    actions: [
                                      TextButton(
                                        child: Text("Close"),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      )
                                    ],
                                  );
                                });
                          },
                          child: ClipRect(
                            child: Text(
                              'View',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModernButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 24),
          decoration: BoxDecoration(
            color: color.withOpacity(0.05),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: color.withOpacity(0.1),
              width: 1.5,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: color, size: 24),
              const SizedBox(width: 12),
              Text(
                label,
                style: TextStyle(
                  color: color,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.8,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> loadModel() async {
    try {
      _interpreter = await tfl.Interpreter.fromAsset('assets/model.tflite');
    } catch (e) {
      debugPrint('Error loading model: $e');
    }
  }

  Future<void> pickImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      _setImage(File(pickedFile.path));
    }
  }

  Future<void> pickImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _setImage(File(pickedFile.path));
    }
  }

  void _setImage(File image) {
    setState(() {
      _image = image;
    });
    if (_interpreter != null) {
      runInference();
    } else {
      debugPrint('Interpreter not initialized');
    }
  }

  Future<Uint8List> preprocessImage(File imageFile) async {
    img.Image? originalImage = img.decodeImage(await imageFile.readAsBytes());
    if (originalImage == null) {
      throw Exception('Failed to decode image');
    }
    img.Image resizedImage =
        img.copyResize(originalImage, width: 250, height: 250);

    List<int> bytes = resizedImage.getBytes();
    List<double> normalizedBytes = bytes.map((byte) => byte / 250.0).toList();

    return Uint8List.fromList(
        normalizedBytes.map((d) => (d * 250).toInt()).toList());
  }

  Future<void> runInference() async {
    if (_labels == null || _labels!.isEmpty) {
      debugPrint('Labels not loaded');
      return;
    }

    try {
      Uint8List inputBytes = await preprocessImage(_image);
      var input = inputBytes.buffer.asUint8List().reshape([1, 250, 250, 3]);

      var outputBuffer = List<double>.filled(6, 0).reshape([1, 6]);
      debugPrint(
          "Model output shape: ${_interpreter!.getOutputTensor(0).shape}");

      _interpreter!.run(input, outputBuffer);

      List<int> output = outputBuffer[0];
      int highestProbIndex = output.indexOf(output.reduce(max));
      String classificationResult = _labels![highestProbIndex];

      String objectType = determineObjectType(classificationResult);

      setState(() {
        _result = classificationResult;
        _objectType = objectType;
      });

      navigateToResult();
    } catch (e) {
      debugPrint('Error during inference: $e');
    }
  }

  String determineObjectType(String classificationResult) {
    final parts = classificationResult.split(' ');
    final className = parts.length > 1
        ? parts[1].toLowerCase()
        : classificationResult.toLowerCase();

    switch (className) {
      case 'glass':
      case 'metal':
      case 'plastic':
        return 'Non-biodegradable';
      case 'paper':
      case 'cardboard':
        return 'Biodegradable';
      default:
        return 'Unknown';
    }
  }

  Future<List<String>> loadLabels() async {
    try {
      final labelsData =
          await DefaultAssetBundle.of(context).loadString('assets/labels.txt');
      return labelsData.split('\n').map((label) => label.trim()).toList();
    } catch (e) {
      debugPrint('Error loading labels file: $e');
      return [];
    }
  }

  void navigateToResult() {
    if (_result != null && _objectType != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MyResult(
            image: _image,
            result: _result!,
            objectType: _objectType!,
          ),
        ),
      );
    }
  }
}
