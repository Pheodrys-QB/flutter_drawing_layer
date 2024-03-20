import 'dart:ui';
import 'package:drawing_layer/draw_command/shape_draw_command.dart';

class OvalDrawCommand extends ShapeDrawCommand {
  OvalDrawCommand(super.color, {super.start, super.end});

  @override
  void draw(Canvas canvas, Size size) {
    canvas.drawOval(
      Rect.fromLTRB(start.dx, start.dy, end.dx, end.dy),
      Paint()..color = color
    );
  }
}