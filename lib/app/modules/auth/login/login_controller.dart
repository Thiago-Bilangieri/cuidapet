// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cuida_pet/app/core/exceptions/failure.dart';
import 'package:cuida_pet/app/core/exceptions/user_not_exist_exception.dart';
import 'package:cuida_pet/app/core/ui/widgets/loader.dart';
import 'package:cuida_pet/app/core/ui/widgets/messages.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import 'package:cuida_pet/app/core/logger/app_logger.dart';
import 'package:cuida_pet/app/services/user/user_service.dart';

part 'login_controller.g.dart';

class LoginController = LoginControllerBase with _$LoginController;

abstract class LoginControllerBase with Store {
  final UserService _userService;
  final AppLogger _appLogger;
  LoginControllerBase({
    required UserService userService,
    required AppLogger appLogger,
  })  : _appLogger = appLogger,
        _userService = userService;

  Future<void> login(String login, String password) async {
    try {
      Loader.show();
      await _userService.login(login, password);
      Loader.hide();
      Modular.to.navigate("/home");
    } on UserNotExistException catch (e, s) {
      Loader.hide();
      _appLogger.error(e.message ?? "", e, s);
      Messages.alert(e.message ?? "Usuario não existe");
    } on Failure catch (e, s) {
      Loader.hide();
      _appLogger.error(e.message ?? "", e, s);
      Messages.alert(e.message ?? "Erro ao logar");
    }
    //  finally {
    //   Loader.hide();
    // }
  }
}
