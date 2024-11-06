import 'package:flutter/material.dart';

class SadEmojiFace extends StatelessWidget {
  const SadEmojiFace({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: SadFacePainter(),
      child: Container(
        width: 100,
        height: 100,
      ),
    );
  }
}

class SadFacePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.yellow
      ..style = PaintingStyle.fill;

    // draw face
    canvas.drawOval(Rect.fromLTWH(0, 0, size.width, size.height), paint);

    // draw left eye
    canvas.drawOval(Rect.fromLTWH(size.width / 3, size.height / 3, size.width / 10, size.height / 10), paint);

    // draw right eye
    canvas.drawOval(Rect.fromLTWH(size.width * 2 / 3, size.height / 3, size.width / 10, size.height / 10), paint);

    // draw mouth
    canvas.drawArc(
      Rect.fromLTWH(size.width / 3, size.height * 2 / 3, size.width / 3, size.height / 10),
      0,
      3.14, // radians
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}