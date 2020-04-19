import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'plane_event.dart';
part 'plane_state.dart';

class PlaneBloc extends Bloc<PlaneEvent, PlaneState> {
  final double _cellSize;

  PlaneBloc({@required double cellSize})
      : assert(cellSize > 0),
        _cellSize = cellSize;

  @override
  PlaneState get initialState => StillState(_cellSize);

  @override
  Stream<PlaneState> mapEventToState(
    PlaneEvent event,
  ) async* {
    if (event is StartScaling) {
      yield* _mapStartScalingToState(event);
    } else if (event is StopScaling) {
      yield* _mapStopScalingToState(event);
    } else {

    }
  }

  @override
  Future<double> close() {
    return super.close();
  }

  Stream<PlaneState> _mapStartScalingToState(StartScaling startScaling) async* {
    yield ScalingState(startScaling.cellSize);
  }

  Stream<PlaneState> _mapStopScalingToState(StopScaling stopScaling) async* {
    yield StillState(stopScaling.cellSize);
  }
}
