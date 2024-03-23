// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

class CanvasAPI_demo extends StatelessWidget {
  const CanvasAPI_demo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Canvas demo"),
      ),
      body: SafeArea(
          child: CustomPaint(
        size: Size.infinite,
        painter: LogoPainter(),
      )),
    );
  }
}

class LogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double xCenter = size.width / 2;
    double yCenter = size.height / 2;

    // Rect boundingBox = Rect.fromCenter(
    //     center: Offset(xCenter, yCenter), width: 150, height: 150);
    // canvas.saveLayer(
    //     boundingBox, Paint()..color = Colors.transparent.withOpacity(0.5));
    // canvas.drawRect(Rect.fromLTWH(xCenter, yCenter, 100, 200), Paint()..color=Colors.red);
    // canvas.drawRect(Rect.fromLTWH(xCenter, yCenter, 100, 200), Paint()..color=Colors.blue);
    // canvas.drawRect(Rect.fromLTWH(xCenter, yCenter, 100, 200), Paint()..color=Colors.green);
    // canvas.restore();

    canvas.drawRect(Rect.fromLTWH(xCenter - 25, yCenter - 25, 100, 200),
        Paint()..color = Colors.red.withOpacity(0.5));

    // canvas.save();

    // canvas.translate(50, 10);
    // canvas.rotate(0.5);
    // canvas.skew(50, 0);
    // canvas.scale(2);

    // Matrix4 matrix = Matrix4.identity();
    // matrix.setEntry(3, 0, 0.001);
    // canvas.transform(matrix.storage);

    canvas.drawRect(Rect.fromLTWH(xCenter, yCenter, 100, 200),
        Paint()..color = Colors.blue.withOpacity(0.5));

    // canvas.restore();

    canvas.drawRect(Rect.fromLTWH(xCenter + 25, yCenter + 25, 100, 200),
        Paint()..color = Colors.green.withOpacity(0.5));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
