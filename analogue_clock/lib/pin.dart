import 'needle.dart';

import 'package:flutter/material.dart';

///Essentially just a circle that is meant to 'hold' a [Needle] in place
class Pin extends StatelessWidget {
  const Pin(
      {Key key,
      this.alignment = Alignment.center,
      this.radius = 10,
      this.color = Colors.black,
      this.child})
      : super(key: key);
  final Alignment alignment;
  final double radius;
  final Color color;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: PinPainter(alignment: alignment, radius: radius, color: color),
      size: MediaQuery.of(context).size,
    );
  }
}

class PinPainter extends CustomPainter {
  const PinPainter({this.alignment, this.radius, this.color});

  final Alignment alignment;
  final Color color;
  final double radius;
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    paint.color = color;

    Offset center;
    if (alignment == Alignment.center) {
      center = Offset(size.width / 2, size.height / 2);
    } else if (alignment == Alignment.bottomCenter) {
      center = Offset(size.width / 2, size.height);
    } else if (alignment == Alignment.topCenter) {
      center = Offset(size.width / 2, 0);
    } else {
      center = Offset(0, 0);
    }
    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(CustomPainter old) => false;
}
