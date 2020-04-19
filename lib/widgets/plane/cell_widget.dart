import 'package:flutter/material.dart';

class CellWidget extends StatelessWidget {
  final double _cellSize;

  get cellSize => _cellSize;

  const CellWidget(this._cellSize)
      : assert(_cellSize > 0);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _cellSize,
      height: _cellSize,
      decoration: BoxDecoration(
        border: Border.all(width: 0.1),
      ),
    );
  }
}
