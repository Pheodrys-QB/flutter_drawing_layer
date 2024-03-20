import 'package:drawing_layer/draw_command/draw_command.dart';
import 'package:drawing_layer/draw_setting.dart';
import 'package:flutter/material.dart';

class FreeDrawPainter extends CustomPainter {
  final DrawCommand? currentCommand;

  bool needRepaint;

  FreeDrawPainter({this.currentCommand}) : needRepaint = true;

  @override
  void paint(Canvas canvas, Size size) {
    _drawOldCommands(canvas, size);
    currentCommand?.draw(canvas, size);
  }

  void _drawOldCommands(Canvas canvas, Size size) {
    for (final command in DrawSettings.commands) {
      command.draw(canvas, size);
    }
  }

  @override
  bool? hitTest(Offset position) => true;

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    var shouldRepaint = needRepaint;
    needRepaint = false;
    return shouldRepaint;
  }
}