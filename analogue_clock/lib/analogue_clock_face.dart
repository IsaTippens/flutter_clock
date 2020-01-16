import 'radial_dial.dart';

import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AnalogueClockFace extends StatelessWidget {
  const AnalogueClockFace({Key key, @required this.now}) : super(key: key);

  final DateTime now;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final clockwise = false;
    
    return Semantics.fromProperties(
      properties: SemanticsProperties(value: DateFormat.Hms().format(now)),
      explicitChildNodes: true,
      child: Stack(
        children: [
          RadialDial(
            length: 12,
            distance: size.height * 7.8 / 10,
            textSize: 60,
            value: now.hour + (now.minute / 60.0),
            startAtZero: false,
            clockwise: clockwise,
          ),
          RadialDial(
            length: 60,
            distance: size.height * 3 / 5,
            textSize: 25,
            value: now.minute + (now.second / 60),
            useSeperators: true,
            divisor: 5,
            clockwise: clockwise,
          ),
          RadialDial(
            length: 60,
            distance: size.height * 2 / 5,
            textSize: 15,
            value: now.second + (now.millisecond / 1000),
            useSeperators: true,
            divisor: 15,
            clockwise: clockwise,
          ),
        ],
      ),
    );
  }
}
