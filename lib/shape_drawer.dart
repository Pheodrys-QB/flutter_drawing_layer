import 'package:drawing_layer/draw_command/shape_draw_command.dart';
import 'package:drawing_layer/draw_painter.dart';
import 'package:flutter/material.dart';

class ShapeDrawer extends StatefulWidget {
  final ShapeDrawCommand command;

  final void Function()? onDone;

  const ShapeDrawer(this.command, {super.key, this.onDone});

  @override
  State<ShapeDrawer> createState() => _ShapeDrawerState();
}

class _ShapeDrawerState extends State<ShapeDrawer> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: _onDragStart,
      onPanUpdate: _onDragUpdate,
      onPanEnd: _onDragEnd,
      child: CustomPaint(
        size: Size.infinite,
        painter: FreeDrawPainter(currentCommand: widget.command)
      ),
    );
  }

  void _onDragStart(DragStartDetails details) {
    setState(() {
      widget.command.start = details.localPosition;
      widget.command.end = widget.command.start;
    });
  }

  void _onDragUpdate(DragUpdateDetails details) {
    setState(() => widget.command.end = details.localPosition);
  }

  void _onDragEnd(DragEndDetails details) {
    widget.onDone?.call();
  }
}