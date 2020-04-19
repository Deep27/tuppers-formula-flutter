import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'plane_event.dart';
part 'plane_state.dart';

class PlaneBloc extends Bloc<PlaneEvent, PlaneState> {
  final int _cellSize;

  PlaneBloc({@required int cellSize})
      : assert(cellSize > 0),
        _cellSize = cellSize;

  @override
  PlaneState get initialState => Still(_cellSize);

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
  Future<int> close() {
    return super.close();
  }

  Stream<PlaneState> _mapStartScalingToState(StartScaling startScaling) async* {
    yield Scaling(startScaling.cellSize);
  }

  Stream<PlaneState> _mapStopScalingToState(StopScaling stopScaling) async* {
    yield Still(stopScaling.cellSize);
  }
}
