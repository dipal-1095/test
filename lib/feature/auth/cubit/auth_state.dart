enum AuthStatus { initial, loading, success, error }

class AuthState {
  final AuthStatus authStatus;
  final String? message;

  AuthState({this.authStatus = AuthStatus.initial, this.message});

  AuthState copyWith({AuthStatus? status, String? message}) {
    return AuthState(
      authStatus: status ?? this.authStatus,
      message: message ?? this.message,
    );
  }
}
