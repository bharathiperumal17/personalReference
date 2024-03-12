
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toggletheme/bloc/counter_bloc.dart';
import 'package:toggletheme/cubit/counter_cubit.dart';
import 'package:toggletheme/dummypage.dart';

class IncDecPage extends StatelessWidget {
  const IncDecPage({super.key});

    
  @override
  Widget build(BuildContext context) {
    final counterCubit=BlocProvider.of<CounterCubit>(context);
    final counterBloc=BlocProvider.of<CounterBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Counter inc or dec'),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Text('Couter Cubit Increment and Decrement'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              FloatingActionButton(
                onPressed: ()=>counterCubit.increment(),
                child: const Icon(Icons.arrow_upward),
              ),
               FloatingActionButton(
                onPressed:()=>counterCubit.decrement(),
                child: const Icon(Icons.arrow_downward),
              ),
            ],
          ),
          const Text('Counter Bloc Increment and Decrement'),
            Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              FloatingActionButton(
                onPressed: ()=>counterBloc.add(CounterIncrement()),
                child: const Icon(Icons.arrow_upward),
              ),
               FloatingActionButton(
                onPressed:()=>counterBloc.add(CounterDecrement()),
                child: const Icon(Icons.arrow_downward),
              ),
              FloatingActionButton(
                onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (context) =>const DummyPage(),)),
                child: const Icon(Icons.navigate_next_outlined),
              ),
            ],
          ),
        ],
      ),
    );

  }
}