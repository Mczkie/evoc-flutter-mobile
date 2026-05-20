import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyLocation extends StatefulWidget {
  const MyLocation({
    super.key,
    required this.onSelectedLocation,
  });
  final Function(String) onSelectedLocation;

  @override
  State<MyLocation> createState() => _MyLocationState();
}

class _MyLocationState extends State<MyLocation> {
  String? selectedLocation;

  final List<String> locationOptions = [
    'East Bajac-Bajac',
    'East Tapinac',
    'Mabayuan',
    'Barretto',
    'Pag-asa',
    'Banicain',
    'Kalaklan',
    'Kalalake',
    'West Tapinac',
    'Sta. Rita',
    'Gordon Heights',
    'Old Cabalan',
    'New Cabalan',
    'New Ilalim',
    'West Bajac-Bajac',
    'Asinan',
  ];

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      value: selectedLocation,
      hint: Text('Select Location'),
      isExpanded: true,
      items: locationOptions.map(
        (i) {
          return DropdownMenuItem(
            value: i,
            child: Text(i),
          );
        },
      ).toList(),
      onChanged: (value) {
        setState(() {
          selectedLocation = value;
          print("Selected Location: $selectedLocation");
        });
        widget.onSelectedLocation(selectedLocation!);
      },
    );
  }
}
