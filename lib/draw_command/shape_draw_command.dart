import 'package:drawing_layer/draw_command/draw_command.dart';
import 'package:flutter/material.dart';

abstract class ShapeDrawCommand extends DrawCommand {
  Offset start;

  Offset end;

  ShapeDrawCommand(super.color, {this.start = Offset.zero, this.end = Offset.zero});

  @override
  String toString() {
    return "Shape (${start.dx},${start.dy}) (${end.dx},${end.dy})";
  }
}