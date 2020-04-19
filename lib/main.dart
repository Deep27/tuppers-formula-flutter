import 'package:flutter/material.dart';

import './screens/home_screen.dart';

void main() => runApp(MyApp());

const PROJECT_NAME = "Tupper's formula";

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: PROJECT_NAME,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(title: PROJECT_NAME),
    );
  }
}

