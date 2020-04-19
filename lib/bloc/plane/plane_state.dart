part of 'plane_bloc.dart';

abstract class PlaneState extends Equatable {
  final int cellSize;

  const PlaneState(this.cellSize);

  @override
  List<Object> get props => [cellSize];
}

class Still extends PlaneState {
  const Still(int cellSize) : super(cellSize);

  @override
  String toString() => 'Stopped scaling { cellSize: $cellSize }';
}

class Scaling extends PlaneState {
  const Scaling(int cellSize) : super(cellSize);

  @override
  String toString() => 'Scaling { cellSize: $cellSize }';
}
