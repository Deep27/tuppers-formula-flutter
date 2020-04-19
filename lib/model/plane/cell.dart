import 'dart:math';

import 'package:flutter/cupertino.dart';

class Cell {
  final Point _point;
  bool _checked = false;

  Cell({@required int x, @required int y, bool checked})
      : assert(x >= 0 && y >= 0),
        _point = Point(x, y);
}
