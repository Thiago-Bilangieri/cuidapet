// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cuida_pet/app/core/exceptions/user_exist_exception.dart';
import 'package:cuida_pet/app/core/ui/widgets/loader.dart';
import 'package:cuida_pet/app/core/ui/widgets/messages.dart';
import 'package:mobx/mobx.dart';

import 'package:cuida_pet/app/core/logger/app_logger.dart';
import 'package:cuida_pet/app/services/user/user_service_impl.dart';

part 'register_controller.g.dart';

class RegisterController = RegisterControllerBase with _$RegisterController;

abstract class RegisterControllerBase with Store {
  final AppLogger _log;
  final UserServiceImpl _userService;
  RegisterControllerBase({
    required AppLogger log,
    required UserServiceImpl userService,
  })  : _log = log,
        _userService = userService;

  Future<void> register(
      {required String email, required String password}) async {
    try {
      Loader.show();
      await _userService.register(email, password);
      Messages.info(
          "Enviamos um email de confirmaão, por favor olhe sua caixa de email.");
      Loader.hide();
    } on UserExistException {
      Loader.hide();
      Messages.alert("Email ja utilizado.");
    } catch (e, s) {
      _log.error("Erro ao registrar usuário", e, s);
      Loader.hide();
      Messages.alert("Erro ao registrar usuário");
    }
  }
}
