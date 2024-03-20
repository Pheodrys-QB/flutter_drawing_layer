import 'package:drawing_layer/draw_command/polygon_draw_command.dart';
import 'package:drawing_layer/draw_painter.dart';
import 'package:drawing_layer/draw_setting.dart';
import 'package:flutter/material.dart';

class PolygonDrawer extends StatefulWidget {
  final Color color;

  final void Function(PolygonDrawCommand? command)? onDone;

  const PolygonDrawer(this.color, {super.key, this.onDone});

  @override
  State<PolygonDrawer> createState() => _PolygonDrawerState();
}

class _PolygonDrawerState extends State<PolygonDrawer> {
  final List<Offset> _points = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _points.add(_points[0]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTap,
      child: CustomPaint(
        size: Size.infinite,
        painter: FreeDrawPainter()
      ),
    );
  }

  void _onTap(TapDownDetails details) {
    if (_points.length == 1) {
      DrawSettings.commands.add(PolygonDrawCommand(color: widget.color, points: _points));
    }

    setState(() => _points.add(details.localPosition));
  }
}