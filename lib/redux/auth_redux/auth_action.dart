// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:storeapp/presentation/auth/auth.dart';

class AuthActionSet {
  final AuthModel authModel;

  AuthActionSet({
    required this.authModel,
  });
}

class ActionClear {
  String? type;
  ActionClear({
    this.type,
  });
}
