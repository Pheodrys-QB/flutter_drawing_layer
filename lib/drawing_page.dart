import 'package:drawing_layer/draw_command/circle_draw_command.dart';
import 'package:drawing_layer/draw_command/draw_command.dart';
import 'package:drawing_layer/draw_command/oval_draw_command.dart';
import 'package:drawing_layer/draw_command/rect_draw_command.dart';
import 'package:drawing_layer/draw_command/shape_draw_command.dart';
import 'package:drawing_layer/draw_setting.dart';
import 'package:drawing_layer/polygon_drawer.dart';
import 'package:drawing_layer/shape_drawer.dart';
import 'package:flutter/material.dart';

class DrawingPage extends StatefulWidget {
  static final List<Color> paintColors = [Colors.red, Colors.green, Colors.blue];

  const DrawingPage({super.key});

  @override
  State<DrawingPage> createState() => _DrawingPageState();
}

class _DrawingPageState extends State<DrawingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Drawing app"),
        actions: [
          IconButton(
            onPressed: () => setState(() => DrawSettings.commands.removeLast()),
            icon: const Icon(Icons.undo)
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size(double.infinity, 55),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              DropdownMenu<Color>(
                initialSelection: DrawSettings.color,
                onSelected: (selectedColor) => setState(() => DrawSettings.color = selectedColor ?? Colors.red),
                dropdownMenuEntries: _getColorEntries()
              ),
              DropdownMenu<DrawMode>(
                initialSelection: DrawSettings.mode,
                onSelected: (selectedMode) => setState(() => DrawSettings.mode = selectedMode ?? DrawMode.circle),
                dropdownMenuEntries: _getDrawModeEntries()
              ),
            ],
          ),
        ),
      ),
      body: _getDrawerWidget(),
    );
  }

  List<DropdownMenuEntry<Color>> _getColorEntries() {
    var entries = <DropdownMenuEntry<Color>>[];

    for (final color in DrawingPage.paintColors) {
      entries.add(DropdownMenuEntry<Color>(
        value: color,
        label: color.value.toRadixString(16),
        style: MenuItemButton.styleFrom(foregroundColor: color)
      ));
    }

    return entries;
  }

  List<DropdownMenuEntry<DrawMode>> _getDrawModeEntries() {
    var entries = <DropdownMenuEntry<DrawMode>>[];

    for (final mode in DrawMode.values) {
      entries.add(DropdownMenuEntry<DrawMode>(
        value: mode,
        label: mode.toString()
      ));
    }

    return entries;
  }

  Widget _getDrawerWidget() {
    if (DrawSettings.mode == DrawMode.polygon) {
      return PolygonDrawer(DrawSettings.color, onDone: _onDoneDraw);
    }

    var command = _getDrawCommand();
    return ShapeDrawer(command, onDone: () => setState(() => DrawSettings.commands.add(command)));
  }

  void _onDoneDraw(DrawCommand? command) {
    setState(() {
      if (command != null) {
        DrawSettings.commands.add(command);
      }
    });
  }

  ShapeDrawCommand _getDrawCommand() {
    switch (DrawSettings.mode)
    {
      case DrawMode.circle:
        return CircleDrawCommand(DrawSettings.color);
      case DrawMode.oval:
        return OvalDrawCommand(DrawSettings.color);
      case DrawMode.rect:
        return RectDrawCommand(DrawSettings.color);
      default:
        throw Exception("No draw command for ${DrawSettings.mode}");
    }
  }
}