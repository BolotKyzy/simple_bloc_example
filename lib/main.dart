import 'package:bloc_counter_project/domain/blocs/user_cubit.dart';
import 'package:bloc_counter_project/example_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: Provider<UsersBloc>(
      //   create: (_) => UsersBloc(),
      //   child: const ExampleWidget(),
      //   dispose: (context, value) => value.close(),
      // ),
      home: BlocProvider<UsersCubit>(
        create: (_) => UsersCubit(),
        child: const ExampleCubit(),
      ),
    );
  }
}
