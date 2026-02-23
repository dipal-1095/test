import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice/app_constant.dart';
import 'package:practice/core/dio_client.dart';
import 'package:practice/feature/home/cubit/user_status.dart';
import 'package:practice/feature/home/model/user_model.dart';
import 'package:practice/feature/home/repo/user_repo.dart';

class UserCubit extends Cubit<UserState> {
  late final UserRepo userRepo;
  UserCubit() : super(UserState()) {
    final dioClient = DioClient(AppConstant.baseUrl);
    userRepo = UserRepo(dioClient);
  }

  Future<void> fetchUser() async {
    try {
      emit(state.copyWith(status: UserStatus.loading));

      final users = await userRepo.fetchUser();

      if (users.isNotEmpty) {
        emit(state.copyWith(status: UserStatus.success, userModel: users));
      } else {
        emit(state.copyWith(status: UserStatus.empty, userModel: []));
      }
    } catch (e) {
      throw Exception("Failed to fetch user list : $e");
    }
  }

  Future<void> deleteUser(String id) async {
    try {
      emit(state.copyWith(status: UserStatus.loading));

      await userRepo.deleteUser(id);

      final userList = state.users?.where((user) => user.id != id).toList();
      emit(state.copyWith(status: UserStatus.deleted, userModel: userList));
    } catch (e) {
      throw Exception("Failed to delete user: $e");
    }
  }

  Future<void> updateUser(String id, UserModel userModel) async {
    try {
      emit(state.copyWith(status: UserStatus.loading));

      final response = await userRepo.updateUser(id, userModel);

      final userList = await userRepo.fetchUser();
      if (response != null) {
        emit(state.copyWith(status: UserStatus.success, userModel: userList));
      }
    } catch (e) {
      throw Exception("Failed to update user: $e");
    }
  }
}
