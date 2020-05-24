import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:tuppers_formula/widgets/gesture_test_widget.dart';

import './screens/home_screen.dart';

void main() {
//  debugRepaintRainbowEnabled = true;
  runApp(MyApp());
}

const PROJECT_NAME = "Tupper's formula";

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    return MaterialApp(
      title: PROJECT_NAME,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: Center(
          child: GestureTestWidget(),
        ),
      ),
    );
  }
}
