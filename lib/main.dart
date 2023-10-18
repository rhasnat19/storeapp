import 'package:flutter_redux/flutter_redux.dart';
import 'package:storeapp/presentation/auth/auth.dart';
import 'package:storeapp/presentation/splash_screen/splash_screen.dart';

import 'utils/di/di.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupDI();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AuthState>(
      store: authStore,
      child: StoreProvider<ProductState>(
        store: productStore,
        child: MaterialApp(
          title: 'Store App',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          debugShowCheckedModeBanner: false,
          home: const SplashScreen(),
        ),
      ),
    );
  }
}
