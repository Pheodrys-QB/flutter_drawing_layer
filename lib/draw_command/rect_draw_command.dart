import 'dart:ui';
import 'package:drawing_layer/draw_command/shape_draw_command.dart';

class RectDrawCommand extends ShapeDrawCommand {
  RectDrawCommand(super.color, {super.start, super.end});

  @override
  void draw(Canvas canvas, Size size) {
    canvas.drawRect(
      Rect.fromLTRB(start.dx, start.dy, end.dx, end.dy),
      Paint()..color = color
    );
  }
}