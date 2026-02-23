import 'package:flutter/animation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice/app_constant.dart';
import 'package:practice/core/dio_client.dart';
import 'package:practice/feature/auth/cubit/auth_state.dart';
import 'package:practice/feature/auth/model/login_request_model.dart';
import 'package:practice/feature/auth/model/login_response_model.dart';
import 'package:practice/feature/auth/repo/auth_repo.dart';

class AuthCubit extends Cubit<AuthState> {
  late final AuthRepo authRepo;

  AuthCubit() : super(AuthState()) {
    final dioClient = DioClient(AppConstant.baseUrl);
    authRepo = AuthRepo(dioClient);
  }

  Future<void> login(String email, String password) async {
    try {
      emit(state.copyWith(status: AuthStatus.loading));

      final request = LoginRequestModel(email: email, password: password);

      final response = await authRepo.login(request);

      emit(
        state.copyWith(status: AuthStatus.success, message: "Login success"),
      );
    } catch (e) {
      emit(state.copyWith(status: AuthStatus.error, message: e.toString()));
    }
  }
}
