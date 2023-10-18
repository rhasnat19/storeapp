import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:storeapp/presentation/auth/auth.dart';
import 'package:storeapp/presentation/auth/enum/auth_enum.dart';
import 'package:storeapp/presentation/product_listing/screens/product_listing_screen.dart';
import 'package:storeapp/presentation/splash_screen/splash_screen.dart';
import 'package:storeapp/utils/utils.dart';

class AuthViewModel {
  final SharedPrefsManager _sharedPrefsManager;
  AuthViewModel(this._sharedPrefsManager);

  void updateAuthModel(AuthEnum field, String value, BuildContext context) {
    final currentStore = StoreProvider.of<AuthState>(context);
    final currentAuthModel = currentStore.state.authModel;
    final updatedAuthModel = AuthModel(
      email: field == AuthEnum.email ? value : currentAuthModel?.email ?? "",
      password:
          field == AuthEnum.password ? value : currentAuthModel?.password ?? "",
    );
    final action = AuthActionSet(authModel: updatedAuthModel);
    currentStore.dispatch(action);
  }

  ///it will handle the login state, as of now. just saving a bool to local storage
  Future signIn(BuildContext context) async {
    try {
      await _sharedPrefsManager.saveData(_sharedPrefsManager.isLogin, true);

      if (context.mounted) {
        StoreProvider.of<AuthState>(context)
            .dispatch(ActionClear(type: "clear auth model"));
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => const ProductListingScreen()));
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future signOut(BuildContext context) async {
    await _sharedPrefsManager.saveData(_sharedPrefsManager.isLogin, null);
    if (context.mounted) {
      StoreProvider.of<ProductState>(context).dispatch(ProductActionClear());
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (BuildContext context) => const AuthScreen(),
        ),
      );
    }
  }

  Future<void> isLogin(BuildContext context) async {
    bool? isLogin = _sharedPrefsManager.getData(_sharedPrefsManager.isLogin);
    if (isLogin ?? false) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) => const ProductListingScreen()));
    } else {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) => const AuthScreen()));
    }
  }
}
