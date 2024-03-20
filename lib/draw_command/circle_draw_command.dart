import 'dart:ui';
import 'package:drawing_layer/draw_command/shape_draw_command.dart';

class CircleDrawCommand extends ShapeDrawCommand {
  CircleDrawCommand(super.color, {super.start, super.end});

  @override
  void draw(Canvas canvas, Size size) {
    canvas.drawCircle(
      (start + end) / 2,
      (start - end).distance / 2,
      Paint()..color = color
    );
  }
}