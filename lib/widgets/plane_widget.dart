import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuppers_formula/bloc/plane/plane_bloc.dart';

class PlaneWidget extends StatefulWidget {
  @override
  _PlaneWidgetState createState() => _PlaneWidgetState();
}

class _PlaneWidgetState extends State<PlaneWidget> {
  int _cellSize = 10;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocProvider(
        create: (context) => PlaneBloc(cellSize: _cellSize),
        child: const Text('AN APP'),
      ),
    );
  }
}
