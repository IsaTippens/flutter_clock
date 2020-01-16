import 'dart:async';

import 'analogue_clock_face.dart';
import 'model.dart';
import 'needle.dart';
import 'pin.dart';

import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class AnalogueClock extends StatefulWidget {
  const AnalogueClock({Key key, this.model}) : super(key: key);
  final TemperatureModel model;
  @override
  createState() => _AnalogueClockState();
}

class _AnalogueClockState extends State<AnalogueClock> {
  Timer _timer;
  DateTime _now = DateTime.now();
  String _city = '';
  String _temperature = '';
  String _temperatureRange = '';
  String _weatherCondition = '';

  @override
  void initState() {
    super.initState();
    _updateTimer();
    widget.model.addListener(_updateModel);
    _updateModel();
  }

  @override
  void didUpdateWidget(AnalogueClock old) {
    super.didUpdateWidget(old);
    if (widget.model != old.model) {
      old.model.removeListener(_updateModel);
      widget.model.addListener(_updateModel);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    widget.model.removeListener(_updateModel);
    widget.model.dispose();
    super.dispose();
  }

  void _updateModel() {
    setState(() {
      var _model = widget.model;
      _city = _model.city;
      _temperature = _model.temperatureString;
      _temperatureRange = '${_model.lowTempString} - ${_model.highTempString}';
      _weatherCondition = _model.weatherConditionString;
    });
  }

  void _updateTimer() {
    setState(() {
      _now = DateTime.now();

      _timer = Timer(
          Duration(milliseconds: 1) - Duration(microseconds: _now.microsecond),
          _updateTimer);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    double textScale = MediaQuery.of(context).textScaleFactor;
    final _temp = Semantics.fromProperties(
        properties: SemanticsProperties(),
        child: DefaultTextStyle(
          style: TextStyle(
              fontSize: 25 * textScale,
              color: Theme.of(context).primaryTextTheme.body1.color),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(_temperature),
                  Text('\t'),
                  Text(_weatherCondition),
                ],
              ),
              Text(
                _temperatureRange,
                style: TextStyle(fontSize: 15 * textScale),
              ),
              Text(_city),
            ],
          ),
        ));

    return Stack(
      children: [
        CustomPaint(
          painter: BGPainter(
            theme: Theme.of(context),
          ),
          size: screen,
        ),
        Positioned(
          top: 0,
          left: 0,
          child: Container(
            padding: EdgeInsets.all(8.0),
            child: Semantics(
              child: _temp,
            ),
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: Container(
            padding: EdgeInsets.all(8),
            child: Text(
              DateFormat.yMMMd().format(_now) + '\n',
              style: TextStyle(
                fontSize: 25 * MediaQuery.of(context).textScaleFactor,
              ),
            ),
          ),
        ),

        //Force the clock face to remain centered at the bottom of the screen
        Transform.translate(
          offset: Offset(0, screen.height / 2),
          child: AnalogueClockFace(now: _now),
        ),
        Needle(
          top: screen.height / 4,
          color: Colors.red,
          child: Pin(
            alignment: Alignment.bottomCenter,
            color: Theme.of(context).primaryColor,
            radius: 25,
          ),
        ),
      ],
    );
  }
}

class BGPainter extends CustomPainter {
  const BGPainter({@required this.theme});
  final ThemeData theme;
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    final color = theme.primaryColor;
    paint.color = color;

    final center = Offset(size.width / 2, size.height);
    var radius = size.height;
    //Outer dark
    canvas.drawCircle(center, radius * 9 / 10, paint);

    //Outer light
    paint.color = theme.scaffoldBackgroundColor;
    canvas.drawCircle(center, radius * 7 / 10, paint);

    //Inner dark
    paint.color = color;
    canvas.drawCircle(center, radius * 5 / 10, paint);

    //Inner light
    paint.color = theme.scaffoldBackgroundColor;
    canvas.drawCircle(center, radius * 3 / 10, paint);
  }

  @override
  bool shouldRepaint(CustomPainter old) => false;
}
