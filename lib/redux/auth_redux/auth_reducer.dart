import 'package:redux/redux.dart';
import 'package:storeapp/presentation/auth/auth.dart';

final authStore = Store<AuthState>(
  authReducer,
  initialState: AuthState.initial(),
);

AuthState authReducer(AuthState newState, dynamic action) {
  if (action is AuthActionSet) {
    return newState.copyWith(
      authModel: action.authModel,
    );
  }
  if (action is ActionClear) {
    if (action.type == "clear auth model") {
      newState.authModel = AuthModel.initial();
    }
  }
  return newState;
}
