import 'package:bloc_counter_project/domain/blocs/user_bloc.dart';
import 'package:bloc_counter_project/example_widget_block.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
      home: Provider(create: (_) => UsersBloc(), child: const ExampleWidget()),
    );
  }
}
