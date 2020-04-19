import 'package:flutter/material.dart';
import 'package:tuppers_formula/widgets/plane/cell_widget.dart';

class PlaneWidget extends StatefulWidget {
  @override
  _PlaneWidgetState createState() => _PlaneWidgetState();
}

class _PlaneWidgetState extends State<PlaneWidget> {
  double _planeScale = 1.0;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final int horizontalCellsAmount = 106;
    final int verticalCellsAmount = 20;
    final double cellSize = screenWidth / horizontalCellsAmount;

    return GestureDetector(
      onScaleUpdate: (scaleDetails) => _updatePlaneScale(scaleDetails.scale),
      child: Transform.scale(
        scale: _planeScale,
        alignment: FractionalOffset.topCenter,
        origin: Offset(50.0, 50.0),
        child: GridView.count(
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: horizontalCellsAmount,
          children: <Widget>[
            ...List.generate(
              horizontalCellsAmount * verticalCellsAmount,
              (i) => CellWidget(cellSize),
            ),
          ],
        ),
      ),
    );
  }

  _updatePlaneScale(double scale) => setState(() => _planeScale = scale);
}
