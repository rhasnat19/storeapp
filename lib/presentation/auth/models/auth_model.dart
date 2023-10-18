// ignore_for_file: public_member_api_docs, sort_constructors_first
class AuthModel {
  AuthModel({
    required this.email,
    required this.password,
  });
  String email;
  String password;

  factory AuthModel.initial() {
    return AuthModel(email: "", password: "");
  }
}
