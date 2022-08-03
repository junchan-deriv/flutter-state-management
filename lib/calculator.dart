import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum CounterOps { increment, decrement, reset }

enum CalculationOps { multiply, divide }

@immutable
abstract class CalculatorOps<T> {
  final T param;
  const CalculatorOps(this.param);
}

class ChangeCounterOps extends CalculatorOps<CounterOps> {
  const ChangeCounterOps(super.param);
}

class SetOperandOps extends CalculatorOps<int> {
  const SetOperandOps(super.param);
}

class CalculatorState {
  int _counter = 0;
  int get counter => _counter;
  int _operand = 0;
  int get operand => _operand;
  CalculatorState clone() {
    CalculatorState ret = CalculatorState();
    ret._counter = _counter;
    ret._operand = _operand;
    return ret;
  }
}

class CalculatorBloc extends Bloc<CalculatorOps, CalculatorState> {
  CalculatorBloc() : super(CalculatorState()) {
    on<ChangeCounterOps>(
      (event, emit) {
        var stateDup = state.clone();
        switch (event.param) {
          case CounterOps.increment:
            stateDup._counter++;
            break;
          case CounterOps.decrement:
            stateDup._counter--;
            break;
          case CounterOps.reset:
            stateDup._counter = 0;
            break;
        }
        emit(stateDup);
      },
    );
    on<SetOperandOps>(
      (event, emit) {
        var stateDup = state.clone();
        stateDup._operand = event.param;
        emit(stateDup);
      },
    );
  }
}
