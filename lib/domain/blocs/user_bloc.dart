import 'dart:async';
import 'dart:math';

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

abstract class UsersEvent {}

class UserIncrementEvent {}

class UserDecrementEvent {}

class UserInitializeEvent {}

class UsersBloc {
  final _userProvider = UserDataProvider();
  var _state = UserState(currentUser: User(0));
  final _stateController = StreamController<UserState>.broadcast();
  UserState get state => _state;
  Stream<UserState> get stream => _stateController.stream;

  UsersBloc() {
    _initialize();
  }
  void dispath(UsersEvent event) {}
  void updateState(UserState state) {
    if (_state == state) return;
    _state = state;
    _stateController.add(state);
  }

  Future<void> _initialize() async {
    final user = await _userProvider.loadValue();
    updateState(_state.copyWith(currentUSer: user));
  }

  void incrementAge() {
    var user = _state.currentUser;
    user = user.copyWith(age: user.age + 1);
    updateState(_state.copyWith(currentUSer: user));
    _userProvider.user = user.copyWith(age: user.age + 1);

    _userProvider.saveValue();
  }

  void decrementAge() {
    var user = _state.currentUser;
    user = user.copyWith(age: user.age - 1);
    updateState(_state.copyWith(currentUSer: user));
    _userProvider.user = user.copyWith(age: max(user.age - 1, 0));
    _userProvider.saveValue();
  }
}
