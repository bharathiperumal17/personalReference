
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toggletheme/bloc/counter_bloc.dart';
import 'package:toggletheme/cubit/counter_cubit.dart';
import 'package:toggletheme/inc_dec_screen.dart';

class HomePageSec extends StatelessWidget {

 
  HomePageSec({super.key});

  @override
  Widget build(BuildContext context) {
    // final counterCubit=BlocProvider.of<CounterCubit>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Counter'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[


            //Counter Cubit
            const Text(
              'You have pushed the counter Cubit button this many times :',
            ),
            BlocBuilder<CounterCubit,int>(
              builder: (context,counter) {
                return Text(
                  '$counter',
                  style: Theme.of(context).textTheme.headlineMedium,
                );
              }
            ),
            //Counter Bloc

             const Text(
              'You have pushed the ounter Bloc button this many times c:',
            ),
            BlocBuilder<CounterBloc,int>(
              builder: (context,counter) {
                return Text(
                  '$counter',
                  style: Theme.of(context).textTheme.headlineMedium,
                );
              }
            ),
          ],
        ),
      ),
      floatingActionButton: 
      // Row(
      //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //   children: [
      //     FloatingActionButton(
      //       onPressed: ()=>counterCubit.increment(),
      //       child: const Icon(Icons.arrow_upward),
          // ),
          FloatingActionButton(
            onPressed:()=>Navigator.push(context,MaterialPageRoute(builder: (context) => const IncDecPage(),)),
            child: const Icon(Icons.navigate_next),
          ),
      //      FloatingActionButton(
      //       onPressed:()=>counterCubit.decrement(),
      //       child: const Icon(Icons.arrow_downward),
      //     ),
          
      //   ],
      // ),
    );
  }
}
