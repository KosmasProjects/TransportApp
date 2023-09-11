import 'package:flutter/material.dart';

class TextFormForTransfers extends StatelessWidget {
  final TextEditingController controller;
  final String hint;

  TextFormForTransfers(
      {super.key, required this.controller, required this.hint});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: TextFormField(
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hint,
              focusedBorder: null,
            ),
            controller: controller,
          ),
        ),
      ),
    );
  }
}
