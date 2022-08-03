import 'package:flutter_bloc/flutter_bloc.dart';

class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0);

  void increment() {
    int newState = state + 1;
    if (newState > 999) {
      newState = 0;
    }
    emit(newState);
  }

  void decrement() {
    int newState = state - 1;
    if (newState < 0) {
      newState = 999;
    }
    emit(newState);
  }

  void reset() {
    emit(0);
  }
}
