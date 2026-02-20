import '../model/user_model.dart';

enum UserStatus { initial, loading, success, error, empty, deleted }

class UserState {
  final UserStatus userStatus;
  final List<UserModel>? users;

  UserState({this.userStatus = UserStatus.initial, this.users});

  UserState copyWith({UserStatus? status, List<UserModel>? userModel}) {
    return UserState(
      userStatus: status ?? this.userStatus,
      users: userModel ?? this.users,
    );
  }
}
