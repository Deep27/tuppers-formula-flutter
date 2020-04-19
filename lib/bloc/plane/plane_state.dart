part of 'plane_bloc.dart';

abstract class PlaneState extends Equatable {
  final double cellSize;

  const PlaneState(this.cellSize);

  @override
  List<Object> get props => [cellSize];
}

class StillState extends PlaneState {
  const StillState(double cellSize) : super(cellSize);

  @override
  String toString() => 'Stopped scaling { cellSize: $cellSize }';
}

class ScalingState extends PlaneState {
  const ScalingState(double cellSize) : super(cellSize);

  @override
  String toString() => 'Scaling { cellSize: $cellSize }';
}
