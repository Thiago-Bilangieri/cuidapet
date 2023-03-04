import 'package:cuida_pet/app/modules/auth/home/auth_home_page.dart';
import 'package:cuida_pet/app/modules/auth/login/login_module.dart';
import 'package:cuida_pet/app/modules/auth/register/register_module.dart';
import 'package:cuida_pet/app/repositories/user/user_repository.dart';
import 'package:cuida_pet/app/repositories/user/user_repository_impl.dart';
import 'package:cuida_pet/app/services/user/user_service.dart';
import 'package:cuida_pet/app/services/user/user_service_impl.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AuthModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton<UserRepository>(
      (i) => UserRepositoryImpl(
        log: i(),
        restClient: i(),
      ),
    ),
    Bind.lazySingleton<UserService>(
      (i) => UserServiceImpl(
        localSecureStorage: i(),
        log: i(),
        userRepository: i(),
        localStorage: i(),
      ),
    ),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute,
        child: (context, args) => AuthHomePage(authStore: Modular.get())),
    ModuleRoute("/login", module: LoginModule()),
    ModuleRoute("/register", module: RegisterModule()),
  ];
}
