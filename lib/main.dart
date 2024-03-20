import 'package:drawing_layer/drawing_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const _DrawingApp());
}

class _DrawingApp extends StatelessWidget {
  const _DrawingApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Drawing app',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const DrawingPage()
    );
  }
}
