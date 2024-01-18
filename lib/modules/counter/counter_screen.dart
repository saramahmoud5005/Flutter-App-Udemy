import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/modules/counter/Cubit/counter_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Cubit/counter_cubit.dart';

class CounterScreen extends StatelessWidget {
  int counter=1;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => CounterCubit(),
      child: BlocConsumer<CounterCubit,CounterState>(
        listener: (context,state){
          if(state is CounterMinusState){
            print('state: ${state.counter}');
          }
          else  if(state is CounterPlusState){
            print('state: ${state.counter}');
          }
        },
        builder: (context,state){
          return Scaffold(
            appBar: AppBar(
              title: Text('Counter App'),
            ),
            body: Center(

              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: (){
                      CounterCubit.get(context).minus();
                    },
                    child: Text(
                      'Minus',
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  SizedBox(width: 30,),
                  Text(
                    '${CounterCubit.get(context).counter}',
                    style: TextStyle(fontSize: 30),
                  ),
                  SizedBox(width: 30,),
                  TextButton(
                    onPressed: (){
                      CounterCubit.get(context).plus();
                    },
                    child: Text(
                      'Plus',
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
