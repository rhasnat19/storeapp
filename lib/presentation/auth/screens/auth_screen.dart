// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:storeapp/presentation/auth/auth.dart';
import 'package:storeapp/presentation/auth/enum/auth_enum.dart';
import 'package:storeapp/presentation/auth/validator/auth_validator.dart';
import 'package:storeapp/utils/di/di.dart';
import 'package:storeapp/viewmodels/auth/auth.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isSignUp = false;
  var authViewModel = getIt<AuthViewModel>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: StoreConnector<AuthState, AuthState>(
              converter: (store) => store.state,
              builder: (context, state) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TitleWidget(text: isSignUp ? 'Sign Up' : 'Sign In'),
                    const SizedBox(height: 48),
                    CustomTextField(
                      controller: emailController,
                      label: 'Email',
                      hintText: 'e.g. test@test.com',
                      textInputType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      validator: AuthValidator.emailValidator,
                      // initialValue: state.authModel?.email ?? "",
                      inputFormatters: [LengthLimitingTextInputFormatter(150)],
                      errorMessage: null,
                      onChanged: (value) => authViewModel.updateAuthModel(
                          AuthEnum.email, value, context),
                    ),
                    const SizedBox(height: 16),
                    CustomTextField(
                      controller: passController,
                      label: 'Password',
                      hintText: 'e.g. 12345678',
                      obscureText: true,
                      textInputAction: TextInputAction.done,
                      validator: AuthValidator.passwordValidator,
                      // initialValue: state.authModel?.password ?? "",
                      inputFormatters: [LengthLimitingTextInputFormatter(51)],
                      errorMessage: null,
                      onChanged: (value) => authViewModel.updateAuthModel(
                          AuthEnum.password, value, context),
                    ),
                    const SizedBox(height: 48),
                    SignInButton(
                      isSignup: isSignUp,
                      onPressed: _onPressed,
                    ),
                    const SizedBox(height: 16),
                    TextButton(
                      onPressed: () => setState(() => isSignUp = !isSignUp),
                      child: Text('Go to Sign ${isSignUp ? 'Up' : 'In'}'),
                    ),
                  ],
                );
              }),
        ),
      ),
    );
  }

  void _onPressed() {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState?.validate() ?? false) {
      authViewModel.signIn(context);
      setState(() {
        emailController.clear();
        passController.clear();
      });
      return;
    }
  }
}

class SignInButton extends StatelessWidget {
  final bool isSignup;
  final void Function()? onPressed;
  const SignInButton(
      {Key? key, required this.isSignup, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PrimaryButton(
      isLoading: false,
      text: isSignup ? 'Sign Up' : 'Sign In',
      onPressed: onPressed,
    );
  }
}
