import 'package:flutter/material.dart';

class UserRole extends StatefulWidget {
  const UserRole({
    super.key,
    required this.onSelectedRole,
  });

  final Function(String) onSelectedRole;
  @override
  State<UserRole> createState() => _UserRoleState();
}

class _UserRoleState extends State<UserRole> {
  String? selectedRole;

  List<String> rolesOptions = ['Student', 'Normal User'];

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      hint: Text('Select Role'),
      isExpanded: true,
      value: selectedRole,
      items: rolesOptions.map((i) {
        return DropdownMenuItem(
          value: i,
          child: Text(i),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          selectedRole = value;
          print("Selected Role: $selectedRole");
        });
        widget.onSelectedRole(selectedRole!);
      },
    );
  }
}
