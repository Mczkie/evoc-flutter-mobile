import 'package:flutter/material.dart';

class UserName extends StatefulWidget {
  const UserName({
    super.key,
    required this.onUsername,
  });

  final Function(String) onUsername;

  @override
  State<UserName> createState() => _UserNameState();
}

class _UserNameState extends State<UserName> {
  final TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: "Username",
        hintText: "Enter your name",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onChanged: (value) {
        widget.onUsername(value);
      },
    );
  }
}
