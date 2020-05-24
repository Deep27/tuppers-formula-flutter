import 'package:flutter/material.dart';

import 'package:matrix_gesture_detector/matrix_gesture_detector.dart';
import 'dart:math' as math;

class GestureTestWidget extends StatefulWidget {
  const GestureTestWidget({Key key}) : super(key: key);

  @override
  _GestureTestWidgetState createState() => _GestureTestWidgetState();
}

class _GestureTestWidgetState extends State<GestureTestWidget> {
  final field = TuppersField();

  Matrix4 _transformMatrix = Matrix4.identity();
  Matrix4 _secondTransformMatrix = Matrix4.identity();

  final _ValueUpdater<double> _scaleUpdater =
      _ValueUpdater((oldValue, newValue) => newValue / oldValue);

  final _ValueUpdater<Offset> _translationUpdater =
      _ValueUpdater((oldValue, newValue) => newValue - oldValue);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onScaleStart: (details) {
        _translationUpdater.value = details.focalPoint;
        _scaleUpdater.value = 1.0;
      },
      onScaleUpdate: (details) {
        setState(() {
          Offset translationDelta =
              _translationUpdater.update(details.focalPoint);
          Matrix4 translationDeltaMatrix = _translate(translationDelta);
          _transformMatrix *= translationDeltaMatrix;

          RenderBox renderBox = context.findRenderObject();
          Offset focalPoint = renderBox.globalToLocal(details.focalPoint);
          if (details.scale != 1.0) {
            double scaleDelta = _scaleUpdater.update(details.scale);
            Matrix4 scaleDeltaMatrix = _scale(scaleDelta, focalPoint);
            _transformMatrix *= scaleDeltaMatrix;
          }
        });
      },
      child: TuppersField(),
//      child: Container(
//        color: Colors.black,
//        height: 250,
//        width: 300,
//        child: Transform(
//          alignment: Alignment.topRight,
//          transform: _transformMatrix,
//          child: Container(
//            padding: const EdgeInsets.all(8.0),
//            color: const Color(0xFFE8581C),
//            child: Center(
//              child: const Text(
//                'Drag or Zoom in/out',
//                style: TextStyle(fontSize: 50),
//              ),
//            ),
//          ),
//        ),
//      ),
    );
  }
}

class TuppersField extends StatefulWidget {
  @override
  _TuppersFieldState createState() => _TuppersFieldState();
}

class _TuppersFieldState extends State<TuppersField> {
  // 106 x 17
  final tuppersArray = List.generate(
    17,
    (index) => List<bool>.generate(
      106,
      (j) {
        final r = math.Random();
        return r.nextBool();
      },
      growable: false,
    ),
    growable: false,
  );

  Widget _buildGridItems(BuildContext context, int index) {
    int tuppersGridLength = tuppersArray.length;
    int x, y = 0;
    x = (index / tuppersGridLength).floor();
    y = (index % tuppersGridLength);
    return GridTile(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
            width: 0.1,
          ),
        ),
        child: Center(
          child: _buildGridItem(x, y),
        ),
      ),
    );
  }

  Widget _buildGridItem(int x, int y) {
    final color = tuppersArray[y][x] ? Colors.blue : Colors.white;
    return Container(color: color);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1.0,
          child: Container(
            padding: const EdgeInsets.all(1.0),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
                width: 2.0,
              ),
            ),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 106,
              ),
              itemBuilder: _buildGridItems,
              itemCount: 106 * 17,
            ),
          ),
        ),
      ],
    );
  }
}

Matrix4 _scale(double scale, Offset focalPoint) {
  var dx = (1 - scale) * focalPoint.dx;
  var dy = (1 - scale) * focalPoint.dy;

  //  ..[0]  = scale   # x scale
  //  ..[5]  = scale   # y scale
  //  ..[10] = 1       # diagonal "one"
  //  ..[12] = dx      # x translation
  //  ..[13] = dy      # y translation
  //  ..[15] = 1       # diagonal "one"
  return Matrix4(scale, 0, 0, 0, 0, scale, 0, 0, 0, 0, 1, 0, dx, dy, 0, 1);
}

Matrix4 _translate(Offset translation) {
  var dx = translation.dx;
  var dy = translation.dy;

  //  ..[0]  = 1       # x scale
  //  ..[5]  = 1       # y scale
  //  ..[10] = 1       # diagonal "one"
  //  ..[12] = dx      # x translation
  //  ..[13] = dy      # y translation
  //  ..[15] = 1       # diagonal "one"
  return Matrix4(1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, dx, dy, 0, 1);
}

typedef _OnUpdate<T> = T Function(T oldValue, T newValue);

class _ValueUpdater<T> {
  final _OnUpdate _onUpdate;
  T _value;

  _ValueUpdater(_OnUpdate onUpdate) : _onUpdate = onUpdate;

  T get value => _value;

  set value(T value) => _value = value;

  T update(T newValue) {
    T updated = _onUpdate(_value, newValue);
    _value = newValue;
    return updated;
  }
}
