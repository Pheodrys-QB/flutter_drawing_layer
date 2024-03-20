import 'dart:ui';

abstract class DrawCommand {
  final Color color;

  const DrawCommand(this.color);

  void draw(Canvas canvas, Size size);
}