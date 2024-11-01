import 'dart:async';
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

class UserIncrementEvent implements UsersEvent {}

class UserDecrementEvent implements UsersEvent {}

class UserInitializeEvent implements UsersEvent {}

class UsersBloc {
  final _userProvider = UserDataProvider();
  var _state = UserState(currentUser: User(0));
  final _stateController = StreamController<UsersEvent>.broadcast();
  late final Stream<UserState> _stateStream;
  UserState get state => _state;
  Stream<UserState> get stream => _stateStream;

  UsersBloc() {
    dispath(UserInitializeEvent());
    _stateStream = _stateController.stream
        .asyncExpand<UserState>(mapEventToState)
        .asBroadcastStream();
  }
  void dispath(UsersEvent event) {
    _stateController.add(event);
  }

  Stream<UserState> mapEventToState(UsersEvent event) async* {
    if (event is UserInitializeEvent) {
      final user = await _userProvider.loadValue();
      yield UserState(currentUser: user);
    } else if (event is UserIncrementEvent) {
      var user = _state.currentUser;
      user = user.copyWith(age: user.age + 1);
      await _userProvider.saveValue(user);
      yield UserState(currentUser: user);
    } else if (event is UserDecrementEvent) {
      var user = _state.currentUser;
      user = user.copyWith(age: user.age - 1);
      await _userProvider.saveValue(user);
      yield UserState(currentUser: user);
    }
  }
}
