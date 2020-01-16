import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' show radians;

class RadialDial extends StatelessWidget {
  const RadialDial(
      {Key key,
      @required this.length,
      this.value = 0,
      this.distance = 100,
      this.textSize = 50,
      this.useSeperators = false,
      this.divisor = 2,
      this.startAtZero = true,
      this.clockwise = true,
      this.child})
      : assert(divisor != 0),
        super(key: key);
  final num length;
  final num distance;
  final num textSize;
  final num value;
  final bool useSeperators;
  final num divisor;
  final bool startAtZero;
  final bool clockwise;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Stack(
          alignment: Alignment.center,
          children: _buildDialDigits(context),
        ),
        child == null ? Container() : child,
      ],
    );
  }

  List<Widget> _buildDialDigits(BuildContext context) {
    List<Widget> result = new List<Widget>();
    double angleDivisor = radians(360 / length);
    num extender = distance;
    num start = startAtZero ? 0 : 1;
    String digit;

    for (num i = start; i < length + start; i++) {
      if (i % divisor != 0 && useSeperators) {
        digit = '٠';
      } else {
        digit = i.toString();
      }

      double angle = i * angleDivisor -
          radians(360 * this.value / length) +
          (clockwise ? 3.14 : -3.14 / 2);
      var transform = Matrix4.identity();
      if (clockwise) {
        transform.translate(sin(angle) * extender, cos(angle) * extender);
      } else {
        transform.translate(cos(angle) * extender, sin(angle) * extender);
      }
      result.add(
        Container(
          margin: EdgeInsets.all(8.0),
          transform: transform,
          child: Text(digit,
              style: TextStyle(
                fontSize: textSize * MediaQuery.of(context).textScaleFactor,
              )),
        ),
      );
    }
    return result;
  }
}
