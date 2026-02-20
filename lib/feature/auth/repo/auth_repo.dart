import 'package:practice/app_constant.dart';
import 'package:practice/core/dio_client.dart';
import 'package:practice/feature/auth/model/login_request_model.dart';
import 'package:practice/feature/auth/model/login_response_model.dart';

class AuthRepo {
  final DioClient dioClient;

  AuthRepo(this.dioClient);

  Future<LoginResponseModel> login(LoginRequestModel data) async {
    try {
      final response = await dioClient.post(AppConstant.loginUri, data: data);

      return LoginResponseModel.fromJson(response.data);
    } catch (e) {
      throw Exception("Login Failed: $e");
    }
  }
}
