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

class UsersCubit extends Cubit<UserState> {
  final _userProvider = UserDataProvider();

  UsersCubit() : super(UserState(currentUser: User(0))) {
    _initialize();
  }

  Future<void> _initialize() async {
    final user = await _userProvider.loadValue();
    final newState = state.copyWith(currentUSer: user);
    emit(newState);
  }

  Future<void> incrementAge() async {
    var user = state.currentUser;
    user = user.copyWith(age: user.age + 1);
    await _userProvider.saveValue(user);
    emit(state.copyWith(currentUSer: user));
  }

  Future<void> decrementAge() async {
    var user = state.currentUser;
    user = user.copyWith(age: user.age - 1);
    await _userProvider.saveValue(user);
    emit(state.copyWith(currentUSer: user));
  }
}
