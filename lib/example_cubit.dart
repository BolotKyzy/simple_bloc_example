import 'package:bloc_counter_project/domain/blocs/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class ExampleCubit extends StatelessWidget {
  const ExampleCubit({super.key});

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
    return BlocBuilder<UsersCubit, int>(builder: (context, state) {
      return Text("${state}");
    });
  }
}

class AgeIncWidget extends StatelessWidget {
  const AgeIncWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<UsersCubit>();
    return ElevatedButton(
        onPressed: () => bloc.incrementAge(), child: const Text("+"));
  }
}

class AgeDecWidget extends StatelessWidget {
  const AgeDecWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<UsersCubit>();
    return ElevatedButton(
        onPressed: () => bloc.decrementAge(), child: const Text("-"));
  }
}
