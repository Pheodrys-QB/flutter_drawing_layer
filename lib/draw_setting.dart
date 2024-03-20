import 'dart:collection';

import 'package:drawing_layer/draw_command/draw_command.dart';
import 'package:flutter/material.dart';

enum DrawMode {
  circle,
  oval,
  rect,
  polygon
}

class DrawSettings {
  static final Set<void Function()> _listeners = {};

  static Color color = Colors.red;

  static DrawMode mode = DrawMode.circle;

  static final Queue<DrawCommand> commands = Queue();

  static void repaint() {
    for (final listener in _listeners) {
      listener.call();
    }
  }

  static void addRepaintListener(void Function() listener) {
    _listeners.add(listener);
  }

  static void removeRepaintListener(void Function() listener) {
    _listeners.remove(listener);
  }
}