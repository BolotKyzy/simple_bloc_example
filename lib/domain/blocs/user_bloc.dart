import 'package:bloc_counter_project/domain/data_providers/user_data_providers.dart';
import 'package:bloc_counter_project/domain/entity/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

class UserIncrementEvent implements UsersEvent {}

class UserDecrementEvent implements UsersEvent {}

class UserInitializeEvent implements UsersEvent {}

class UserBloc extends Bloc<UsersEvent, UserState> {
  final _userProvider = UserDataProvider();

  UserBloc() : super(UserState(currentUser: User(0))) {
    on<UserInitializeEvent>(
      (event, emit) async {
        print(" Initial - $event - $emit");
        final user = await _userProvider.loadValue();
        final newState = state.copyWith(currentUSer: user);
        emit(newState);
      },
    );
    on<UserIncrementEvent>((event, emit) async {
      print(" Increment - $event - $emit");
      var user = state.currentUser;
      user = user.copyWith(age: user.age + 1);
      await _userProvider.saveValue(user);
      emit(state.copyWith(currentUSer: user));
    });
    on<UserDecrementEvent>((event, emit) async {
      print(" Decrement - $event - $emit");

      var user = state.currentUser;
      user = user.copyWith(age: user.age - 1);
      await _userProvider.saveValue(user);
      emit(state.copyWith(currentUSer: user));
    });
  }
}
