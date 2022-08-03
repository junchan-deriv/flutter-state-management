import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state_management_dude/calculator.dart';
import 'package:state_management_dude/result_page.dart';

void main() {
  runApp(
    BlocProvider(
      create: (ctx) => CalculatorBloc(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Chicken",
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      routes: {ResultPage.route: (_) => const ResultPage()},
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late CalculatorBloc cubit;
  final TextEditingController _controller = TextEditingController(text: "0");
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    cubit = BlocProvider.of<CalculatorBloc>(context);
    _controller.text = cubit.state.operand.toString();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        centerTitle: true,
      ),
      body: BlocBuilder<CalculatorBloc, CalculatorState>(
        builder: (context, state) {
          return DefaultTextStyle(
            style: const TextStyle(fontSize: 30, color: Colors.black),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Wrap(
                    children: [
                      TextField(
                        controller: _controller,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          FilteringTextInputFormatter.singleLineFormatter,
                        ],
                        textAlign: TextAlign.center,
                      ),
                      Center(
                        child: Text(
                          "${state.counter}",
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          cubit.add(
                              const ChangeCounterOps(CounterOps.increment));
                        },
                        child: const Text("+"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          cubit.add(
                              const ChangeCounterOps(CounterOps.decrement));
                        },
                        child: const Text("-"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          cubit.add(const ChangeCounterOps(CounterOps.reset));
                        },
                        child: const Text("0"),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          cubit.add(SetOperandOps(
                              int.tryParse(_controller.text) ?? 0));
                          Navigator.of(context).pushNamed(ResultPage.route,
                              arguments: CalculationOps.multiply);
                        },
                        child: const Text("x"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          cubit.add(SetOperandOps(
                              int.tryParse(_controller.text) ?? 0));
                          Navigator.of(context).pushNamed(ResultPage.route,
                              arguments: CalculationOps.divide);
                        },
                        child: const Text("÷"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () => cubit.increment(),
      //   child: const Icon(Icons.add),
      // ),
    );
  }
}
