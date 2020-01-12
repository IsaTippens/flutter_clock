import 'model.dart';

import 'package:analogue_clock/analogue_clock.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(ClockApp());
  SystemChrome.setEnabledSystemUIOverlays([]);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
}

class ClockApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget _clock = AnalogueClock(
      model: TemperatureModel(),
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: ThemeData(
        backgroundColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
        primaryColor: Colors.grey.shade300,
      ),
      darkTheme: ThemeData.dark(),
      home: Scaffold(
        body: SafeArea(
          child: Center(
            child: AspectRatio(aspectRatio: 5 / 3, child: _clock),
          ),
        ),
      ),
    );
  }
}
