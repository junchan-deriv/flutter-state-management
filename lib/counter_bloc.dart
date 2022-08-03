import 'package:flutter_bloc/flutter_bloc.dart';

abstract class _CounterOperation {}

class IncrementCounter implements _CounterOperation {}

class DecrementCounter implements _CounterOperation {}

class ResetCounter implements _CounterOperation {}

class CounterBloc extends Bloc<_CounterOperation, int> {
  CounterBloc() : super(0) {
    on<IncrementCounter>((event, emit) => emit(state + 1));
    on<DecrementCounter>((event, emit) => emit(state - 1));
    on<ResetCounter>((event, emit) => emit(0));
  }
}
