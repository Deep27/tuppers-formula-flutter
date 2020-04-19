import 'package:flutter/material.dart';
import 'package:tuppers_formula/widgets/drawed_plane_widget.dart';

import '../widgets/plane/plane_widget.dart';

class HomeScreen extends StatefulWidget {
  final String _title;

  HomeScreen({Key key, title})
      : this._title = title,
        super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget._title),
      ),
      body: DrawedPlaneWidget(),
    );
  }
}
