part of 'plane_bloc.dart';

abstract class PlaneEvent extends Equatable {
  final double cellSize;

  const PlaneEvent(this.cellSize);

  @override
  List<Object> get props => [];
}

class StartScaling extends PlaneEvent {
  const StartScaling({@required double cellSize}) : super(cellSize);

  @override
  List<Object> get props => [cellSize];

  @override
  String toString() {
    return "Start scaling { cellSize: $cellSize }";
  }
}

class Scaling extends PlaneEvent {
  const Scaling({@required double cellSize}) : super(cellSize);

  @override
  List<Object> get props => [cellSize];

  @override
  String toString() {
    return "Scaling { cellSize: $cellSize }";
  }
}

class StopScaling extends PlaneEvent {
  const StopScaling({@required double cellSize}) : super(cellSize);

  @override
  List<Object> get props => [cellSize];

  @override
  String toString() {
    return "Stop scaling { cellSize: $cellSize }";
  }
}
