import 'package:flutter/material.dart';

class ErrorWidgetCustom extends StatelessWidget {
  final String message;

  const ErrorWidgetCustom({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        message,
        style: const TextStyle(color: Colors.red, fontSize: 18),
      ),
    );
  }
}