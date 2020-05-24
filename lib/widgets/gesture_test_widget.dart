import 'package:flutter/material.dart';

import 'package:matrix_gesture_detector/matrix_gesture_detector.dart';
import 'dart:math' as math;

class GestureTestWidget extends StatefulWidget {
  const GestureTestWidget({Key key}) : super(key: key);

  @override
  _GestureTestWidgetState createState() => _GestureTestWidgetState();
}

class _GestureTestWidgetState extends State<GestureTestWidget> {

  Matrix4 _transformMatrix = Matrix4.identity();

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
      child: Container(
        color: Colors.black,
        height: 300,
        width: 400,
        child: Transform(
          alignment: Alignment.topRight,
          transform: _transformMatrix,
          child: Container(
            padding: const EdgeInsets.all(8.0),
            color: const Color(0xFFE8581C),
            child: Center(
              child: const Text(
                'Apartment for rent!',
                style: TextStyle(fontSize: 50),
              ),
            ),
          ),
        ),
      ),
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

//  @override
//  Widget build(BuildContext context) {
//    return Container(
//      width: double.infinity,
//      height: double.infinity,
//      child: MatrixGestureDetector(
//        onMatrixUpdate: (Matrix4 m, Matrix4 tm, Matrix4 sm, Matrix4 rm) {
//          setState(() {
//            matrix = m;
//          });
//        },
//        child: Transform(
//          transform: matrix,
//          child: Container(
//            width: 200,
//            height: 200,
//            color: Colors.red,
//          ),
//        ),
//      ),
//    );
//  }
