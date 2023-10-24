import 'dart:math';

import 'package:flutter/material.dart';

class CustomPaintPage extends StatelessWidget {
  const CustomPaintPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("CustomPaintPage")),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RepaintBoundary(
              child: CustomPaint(
                size: const Size(300, 300),
                painter: MyPainter(),
              ),
            ),
            ElevatedButton(onPressed: () {}, child: const Text("Refresh"))
          ],
        ),
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    drawChessBoard(canvas, Offset.zero & size);
    drawPieces(canvas, Offset.zero & size);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

  ///绘制棋盘格
  void drawChessBoard(Canvas canvas, Rect rect) {
    var paint = Paint()
      ..isAntiAlias = true
      ..style = PaintingStyle.fill
      ..color = const Color(0xFFDCC48C);
    canvas.drawRect(rect, paint);

    paint
      ..style = PaintingStyle.stroke
      ..color = Colors.black38
      ..strokeWidth = 1.0;

    for (int i = 0; i < 15; i++) {
      double dy = rect.top + rect.height / 15 * i;
      canvas.drawLine(Offset(rect.left, dy), Offset(rect.right, dy), paint);

      double dx = rect.left + rect.width / 15 * i;
      canvas.drawLine(Offset(dx, rect.top), Offset(dx, rect.bottom), paint);
    }
  }

  void drawPieces(Canvas canvas, Rect rect) {
    double eWidth = rect.width / 15;
    double eHeight = rect.height / 15;
    var paint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.black;

    canvas.drawCircle(
        Offset(rect.center.dx - eWidth / 2, rect.center.dy - eHeight / 2),
        min(eWidth / 2, eHeight / 2) - 2,
        paint);

    paint.color = Colors.white;
    canvas.drawCircle(
        Offset(rect.center.dx + eWidth / 2, rect.center.dy - eHeight / 2),
        min(eWidth / 2, eHeight / 2) - 2,
        paint);
  }
}
