import 'package:flutter/material.dart';

class PopUpTopic extends StatelessWidget {
  final String label;
  const PopUpTopic({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
