import 'package:flutter/material.dart';

class Line extends StatelessWidget {
  const Line({
    Key key,
    this.padding = const EdgeInsets.symmetric(vertical: 10.0),
  }) : super(key: key);

  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: CustomPaint(
        painter: DashedLinePainter(),
        size: Size(MediaQuery.of(context).size.width, 0.0),
      ),
    );
  }
}

class DashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Color(0xFF666666)
      ..strokeWidth = size.height;

    const dash = 4;
    const gap = 2;

    var startX = 0.0;
    var width = size.width;

    while (width >= 0) {
      canvas.drawLine(Offset(startX, 0.0), Offset(startX + dash, 0.0), paint);

      final space = gap + dash;
      startX += space;
      width -= space;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
