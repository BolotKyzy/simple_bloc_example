// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:bloc/bloc.dart';

import 'package:bloc_counter_project/domain/data_providers/user_data_providers.dart';
import 'package:bloc_counter_project/domain/entity/user.dart';

class UserState {
  final User currentUser;
  UserState({
    required this.currentUser,
  });

  UserState copyWith({
    User? currentUSer,
  }) {
    return UserState(
      currentUser: currentUSer ?? currentUser,
    );
  }

  @override
  String toString() => 'UserState(currentUSer: $currentUser)';

  @override
  bool operator ==(covariant UserState other) {
    if (identical(this, other)) return true;

    return other.currentUser == currentUser;
  }

  @override
  int get hashCode => currentUser.hashCode;
}

class UsersCubit extends Cubit<int> {
  final _userProvider = UserDataProvider();
  var _state = UserState(currentUser: User(0));

  UsersCubit() : super(0) {
    _initialize();
  }

  Future<void> _initialize() async {
    final user = await _userProvider.loadValue();
    emit(user.age);
  }

  Future<void> incrementAge() async {
    var user = _state.currentUser;
    user = user.copyWith(age: user.age + 1);
    await _userProvider.saveValue(user);
    emit(state + 1);
  }

  Future<void> decrementAge() async {
    var user = _state.currentUser;
    user = user.copyWith(age: user.age - 1);
    await _userProvider.saveValue(user);
    emit(state - 1);
  }
}
