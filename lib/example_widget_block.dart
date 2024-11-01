import 'package:bloc_counter_project/domain/blocs/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExampleWidget extends StatelessWidget {
  const ExampleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          _AgeWidget(),
          SizedBox(
            height: 20,
          ),
          AgeIncWidget(),
          SizedBox(
            height: 20,
          ),
          AgeDecWidget()
        ]),
      )),
    );
  }
}

class _AgeWidget extends StatelessWidget {
  const _AgeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<UsersBloc>();
    return StreamBuilder<UserState>(
        initialData: bloc.state,
        stream: bloc.stream,
        builder: (context, snapshot) {
          final age = snapshot.requireData.currentUser.age;
          return Text("$age");
        });
  }
}

class AgeIncWidget extends StatelessWidget {
  const AgeIncWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<UsersBloc>();
    return ElevatedButton(onPressed: bloc.incrementAge, child: const Text("+"));
  }
}

class AgeDecWidget extends StatelessWidget {
  const AgeDecWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<UsersBloc>();
    return ElevatedButton(onPressed: bloc.decrementAge, child: const Text("-"));
  }
}
