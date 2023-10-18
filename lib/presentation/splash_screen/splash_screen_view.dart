import 'package:storeapp/utils/di/di.dart';
import 'package:storeapp/viewmodels/auth/auth.dart';

import 'splash_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var authViewModel = getIt<AuthViewModel>();

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 1),
        () async => await authViewModel.isLogin(context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          "Splash Screen",
          textAlign: TextAlign.center,
          maxLines: 4,
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
