import 'package:practice/app_constant.dart';
import 'package:practice/core/dio_client.dart';
import 'package:practice/feature/auth/model/login_request_model.dart';
import 'package:practice/feature/auth/model/login_response_model.dart';
import 'package:practice/feature/home/model/user_model.dart';

class UserRepo {
  final DioClient dioClient;

  UserRepo(this.dioClient);

  Future<List<UserModel>> fetchUser() async {
    try {
      final response = await dioClient.get(AppConstant.fetchUserUri);

      final List data = response.data;

      return data.map((e) => UserModel.fromJson(e)).toList();
    } catch (e) {
      throw Exception("Failed to fetch list: $e");
    }
  }

  Future<void> deleteUser(String id) async {
    try {
      final response = await dioClient.delete(
        "${AppConstant.deleteUserUri}$id",
      );

      return response.data;
    } catch (e) {
      throw Exception("Failed to delete user: $e");
    }
  }

  Future<UserModel> updateUser(String id, UserModel userModel) async {
    try {
      final response = await dioClient.put(
        "${AppConstant.updateUserUri}$id",
        data: userModel,
      );

      return UserModel.fromJson(response.data);
    } catch (e) {
      throw Exception("Failed to update user: $e");
    }
  }
}
