part of 'plane_bloc.dart';

abstract class PlaneEvent extends Equatable {
  const PlaneEvent();

  @override
  List<Object> get props => [];
}

class StartScaling extends PlaneEvent {
  final int cellSize;

  const StartScaling({@required this.cellSize});


  @override
  List<Object> get props => [cellSize];

  @override
  String toString() {
    return "Start scaling { cellSize: $cellSize }";
  }
}

class StopScaling extends PlaneEvent {
  final int cellSize;

  const StopScaling({@required this.cellSize});

  @override
  List<Object> get props => [cellSize];

  @override
  String toString() {
    return "Stop scaling { cellSize: $cellSize }";
  }
}
