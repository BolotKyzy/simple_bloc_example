import 'package:bloc_counter_project/domain/blocs/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class ExampleBloc extends StatelessWidget {
  const ExampleBloc({super.key});

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
    context.read<UserBloc>().add(UserInitializeEvent());
    final age = context.select((UserBloc b) => b.state.currentUser.age);
    return Text("$age");

    // return BlocBuilder<UsersCubit, UserState>(builder: (context, state) {
    //   return Text("${state.currentUser.age}");
    // });
  }
}

class AgeIncWidget extends StatelessWidget {
  const AgeIncWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<UserBloc>();
    return ElevatedButton(
        onPressed: () => bloc.add(UserIncrementEvent()),
        child: const Text("+"));
  }
}

class AgeDecWidget extends StatelessWidget {
  const AgeDecWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<UserBloc>();
    return ElevatedButton(
        onPressed: () => bloc.add(UserDecrementEvent()),
        child: const Text("-"));
  }
}
