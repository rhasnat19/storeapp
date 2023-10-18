// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:storeapp/presentation/auth/auth.dart';

class AuthState {
  AuthModel? authModel;

  AuthState({
    this.authModel,
  });

  AuthState.fromAuthState(AuthState another) {
    authModel = another.authModel;
  }

  factory AuthState.initial() {
    return AuthState(authModel: AuthModel.initial());
  }

  AuthState copyWith({AuthModel? authModel}) {
    return AuthState(
      authModel: authModel ?? this.authModel,
    );
  }
}
