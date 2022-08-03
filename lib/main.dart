import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'counter_cubit.dart';

void main() {
  runApp(
    const MyApp(),
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
      theme: ThemeData(primarySwatch: Colors.orange),
      home: BlocProvider(
        create: (context) => CounterCubit(),
        child: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late CounterCubit cubit;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    cubit = BlocProvider.of<CounterCubit>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        centerTitle: true,
      ),
      body: BlocConsumer<CounterCubit, int>(
        listener: (context, state) {
          const snackBar = SnackBar(content: Text("State is reached"));
          if (state > 0 && state % 5 == 0) {
            ScaffoldMessenger.of(context)
              ..clearSnackBars()
              ..showSnackBar(snackBar);
          }
        },
        builder: (context, state) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "$state",
                  style: const TextStyle(fontSize: 100),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        cubit.increment();
                      },
                      child: const Text("Increment"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        cubit.decrement();
                      },
                      child: const Text("Decrement"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        cubit.reset();
                      },
                      child: const Text("Reset"),
                    ),
                  ],
                )
              ],
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
