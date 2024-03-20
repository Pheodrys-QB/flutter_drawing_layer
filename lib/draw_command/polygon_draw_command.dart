import 'dart:ui';
import 'package:drawing_layer/draw_command/draw_command.dart';
import 'package:flutter/material.dart';

class PolygonDrawCommand extends DrawCommand {
  final List<Offset> points;

  PolygonDrawCommand({Color color = Colors.black, required this.points}) : super(color);

  @override
  void draw(Canvas canvas, Size size) {
    canvas.drawPoints(
      PointMode.polygon,
      points,
      Paint()
        ..blendMode = BlendMode.srcOver
        ..color = color
        ..strokeCap = StrokeCap.round
        ..strokeWidth = 3
    );
  }
}
