import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class DrawedPlaneWidget extends StatefulWidget {
  @override
  _DrawedPlaneWidgetState createState() => _DrawedPlaneWidgetState();
}

class _DrawedPlaneWidgetState extends State<DrawedPlaneWidget> {

  double _planeScale = 1.0;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final int horizontalCellsAmount = 106;
    final int verticalCellsAmount = 20;
    final double cellSize = screenWidth / horizontalCellsAmount;
    return GestureDetector(
      onScaleUpdate: (scaleDetails) => _updatePlaneScale(scaleDetails.scale),
      onTap: () => print('tap'),
      child: Transform.scale(
        scale: _planeScale,
        origin: Offset(50.0, 50.0),
        child: CustomPaint(
          painter: _PlanePainter(
            xStart: 0,
            yStart: 0,
            xEnd: screenWidth,
            yEnd: verticalCellsAmount * cellSize,
          ),
        ),
      ),
    );
  }

  _updatePlaneScale(double scale) => setState(() => _planeScale = scale);
}

class _PlanePainter extends CustomPainter {
  final Rect rect;
  final Paint rectPaint;

  final Paint linePaint;

  final List<List<Offset>> offsets = List(20);

  _PlanePainter(
      {@required double xStart,
      @required double yStart,
      @required double xEnd,
      @required double yEnd})
      : assert(xStart >= 0 && yStart >= 0 && xEnd > xStart && yEnd > yStart),
        rect = Rect.fromLTRB(xStart, yStart, xEnd, yEnd),
        rectPaint = Paint()
          ..color = Colors.black
          ..style = PaintingStyle.stroke
          ..strokeWidth = 0.1,
        linePaint = Paint()
          ..color = Colors.black
          ..strokeWidth = 0.1;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(rect, rectPaint);
    final p1 = Offset(50, 50);
    final p2 = Offset(250, 150);
    canvas.drawLine(p1, p2, linePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
