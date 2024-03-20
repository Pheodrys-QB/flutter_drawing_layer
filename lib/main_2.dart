import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: FutureBuilder(
        future: _loadImage(),
        builder: _buildCustomPaint,
      )
    );
  }

  Widget _buildCustomPaint(context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Text("Loading");
    }

    if (snapshot.connectionState != ConnectionState.done) {
      return Text("Error ${snapshot.error}");
    }

    if (snapshot.data == null) {
      return const Text("Image not found");
    }

    return CustomPaint(
      size: Size.infinite,
      painter: MyPainter(image: snapshot.data!),
    );
  }

  Future<ui.Image> _loadImage() async {
    final data = await rootBundle.load("button.png");
    final completer = Completer<ui.Image>();

    ui.decodeImageFromList(
      Uint8List.view(data.buffer),
      (image) => completer.complete(image)
    );

    return completer.future;
  }
}

class MyPainter extends CustomPainter {
  final ui.Image image;

  MyPainter({super.repaint, required this.image});

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawColor(Colors.white, BlendMode.clear);

    // canvas.clipRect(const Offset(50, 50) & const Size(200, 200));
    // canvas.clipRRect(RRect.fromRectXY(const Offset(100, 60) & const Size(200, 200), 50, 50));

    var rect = const Offset(40, 100) & size / 3 * 2;

    Gradient gradient = const RadialGradient(
      center: Alignment(0, 0),
      radius: 0.2,
      colors: [Color(0xFFFFFF00), Color(0xFF0099FF)],
      stops: [0.4, 1.0],
    );

    canvas.drawRect(
      rect,
      Paint()
        ..shader = gradient.createShader(rect),
    );

    gradient = const LinearGradient(colors: [Colors.red, Colors.green]);
    rect = const Offset(40, 40) & const Size(300, 300);

    canvas.drawArc(
      rect,
      0,
      3 / 2 * 3.14,
      true,
      Paint()
        ..blendMode = BlendMode.color
        ..color = Colors.yellow
        ..shader = gradient.createShader(rect)
    );

    var path = Path();
    //path.addPolygon(const [Offset(50, 50), Offset(120, 60), Offset(100, 70), Offset(70, 200)], false);
    path.addRect(rect);

    canvas.drawShadow(path, Colors.black, 10, true);

    // _drawImage(canvas);

    canvas.drawPoints(
      ui.PointMode.lines,
      const [Offset(50, 50), Offset(120, 60), Offset(100, 70), Offset(70, 200)],
      Paint()
        ..color = Colors.yellow
        ..strokeWidth = 5
    );

  }

  void _drawImage(ui.Canvas canvas) {
    print("${image.width} ${image.height}");
    var sliceOffset = const Offset(70, 50);
    var drawOffset = const Offset(0, 0);
    var imageSize = Size(image.width.toDouble() / 3 * 2, image.height.toDouble() * 2);

    canvas.drawImageNine(
      image,
      //const Offset(50, 50) & Size((image.width - 50).toDouble(), (image.height - 50).toDouble()),
      sliceOffset & Size(image.width.toDouble() - 2 * sliceOffset.dx, image.height.toDouble() - 2 * sliceOffset.dy),
      drawOffset & imageSize,
      Paint()..blendMode = BlendMode.srcOver
    );

    var rectOffset = Offset(drawOffset.dx + sliceOffset.dx, drawOffset.dy + sliceOffset.dy);
    var rectBottomOffset = Offset(drawOffset.dx + imageSize.width - sliceOffset.dx, drawOffset.dy + imageSize.height - sliceOffset.dy);

    var linePaint = Paint()
        ..blendMode = BlendMode.srcOver
        ..color = Colors.green
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1;

    canvas.drawLine(Offset(drawOffset.dx, rectOffset.dy), Offset(drawOffset.dx + imageSize.width, rectOffset.dy), linePaint);
    canvas.drawLine(Offset(drawOffset.dx, rectBottomOffset.dy), Offset(drawOffset.dx + imageSize.width, rectBottomOffset.dy), linePaint);
    canvas.drawLine(Offset(rectOffset.dx, drawOffset.dy), Offset(rectOffset.dx, drawOffset.dy + imageSize.height), linePaint);
    canvas.drawLine(Offset(rectBottomOffset.dx, drawOffset.dy), Offset(rectBottomOffset.dx, drawOffset.dy + imageSize.height), linePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}