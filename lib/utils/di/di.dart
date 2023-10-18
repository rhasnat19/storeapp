import 'package:storeapp/utils/utils.dart';

GetIt getIt = GetIt.instance;

setupDI() async {
  final pref = await SharedPreferences.getInstance();
  getIt.registerLazySingleton(() => pref);

  /// Register Shared Pref Manager that depends on SharedPreferences
  getIt.registerLazySingleton(() => SharedPrefsManager(getIt.get()));

  //creating instance for authViewmodel
  getIt.registerLazySingleton<AuthViewModel>(() => AuthViewModel(getIt.get()));

  //creating instance for product listing repository and its viewmodel
  getIt.registerLazySingleton<ProductRepository>(() => ProductRepository());

  getIt.registerLazySingleton<ProductViewModel>(
      () => ProductViewModel(getIt.get()));
}
