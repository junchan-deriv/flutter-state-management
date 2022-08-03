import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state_management_dude/calculator.dart';

class ResultPage extends StatefulWidget {
  static const String route = "/results";
  const ResultPage({Key? key}) : super(key: key);

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  Widget build(BuildContext context) {
    //get the state
    var bloc = context.watch<CalculatorBloc>().state;
    CalculationOps operation =
        ModalRoute.of(context)?.settings.arguments! as CalculationOps;
    double result = 0;
    bool invalid = false;
    if (operation == CalculationOps.divide && bloc.counter == 0) {
      invalid = true;
    } else {
      if (operation == CalculationOps.multiply) {
        result = bloc.operand.toDouble() * bloc.counter;
      } else {
        result = bloc.operand.toDouble() / bloc.counter;
      }
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Results"),
        centerTitle: true,
      ),
      body: DefaultTextStyle(
        style: const TextStyle(fontSize: 40, color: Colors.black),
        child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(bloc.operand.toString()),
                Text(operation == CalculationOps.multiply ? "x" : "÷"),
                Text(bloc.counter.toString()),
                const Text("="),
                if (invalid)
                  const Text("Canot divide with zero")
                else
                  Text(result.toString())
              ]),
        ),
      ),
    );
  }
}
