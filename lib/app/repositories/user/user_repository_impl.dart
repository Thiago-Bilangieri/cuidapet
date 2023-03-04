// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:cuida_pet/app/core/exceptions/failure.dart';
import 'package:cuida_pet/app/core/exceptions/user_exist_exception.dart';
import 'package:cuida_pet/app/core/logger/app_logger.dart';
import 'package:cuida_pet/app/core/rest_client/rest_client.dart';
import 'package:cuida_pet/app/core/rest_client/rest_client_exception.dart';
import 'package:cuida_pet/app/models/confirm_login_model.dart';
import 'package:cuida_pet/app/models/user_model.dart';
import 'package:cuida_pet/app/repositories/user/user_repository.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class UserRepositoryImpl implements UserRepository {
  final RestClient _restClient;
  final AppLogger _log;
  UserRepositoryImpl({
    required RestClient restClient,
    required AppLogger log,
  })  : _restClient = restClient,
        _log = log;

  @override
  Future<void> register(String email, String password) async {
    try {
      // AQUI
      await _restClient.unAuth().post(
        "/auth/register",
        data: {
          "email": email,
          "password": password,
        },
      );
    } on RestClientException catch (e, s) {
      if (e.statusCode == 400 &&
          e.response.data["message"]
              .toLowerCase()
              .contains("usuário já cadastrado ")) {
        _log.error(e.error, e, s);
        throw UserExistException();
      }
      _log.error("Erro ao Cadastrar usuário", e, s);
      throw Failure(message: "Erro ao registrar usuario");
    }
  }

  @override
  Future<String> login(String email, String password) async {
    try {
      final result = await _restClient.unAuth().post<Map<String, dynamic>>(
        "/auth/",
        data: {
          "login": email,
          "password": password,
          "social_login": false,
          "supplier_user": false
        },
      );
      return result.data?["access_token"];
    } on RestClientException catch (e, s) {
      switch (e.statusCode) {
        case 403:
          _log.error("Usuario cadastrado em um backend e nao no outro", e, s);
          throw Failure(
              message: "Usuario inconsistente, entre em cotato com o suporte");
      }
      _log.error("Erro ao realizar Login", e, s);
      throw Failure(message: "");
    }
  }

  @override
  Future<ConfirmLoginModel> confirmLogin() async {
    try {
      final deviceToken = await FirebaseMessaging.instance.getToken();
      final result = await _restClient.auth().patch("/auth/confirm", data: {
        "ios_token": Platform.isIOS ? deviceToken : null,
        "android_token": Platform.isAndroid ? deviceToken : null,
      });
      return ConfirmLoginModel.fromMap(result.data);
    } on RestClientException catch (e, s) {
      _log.error("Erro ao confirmar login", e, s);
      throw Failure(message: "Erro ao confirmar login");
    } catch (e, s) {
      _log.error("ERRO AQUI", e, s);
      throw Failure(
        message: "",
      );
    }
  }

  @override
  Future<UserModel> getUserLoged() async {
    try {
      final result = await _restClient.auth().get("/user/");
      return UserModel.fromMap(result.data);
    } on RestClientException catch (e, s) {
      _log.error("Erro ao buscar dados do usuario Logado!", e, s);
      throw Failure(message: "Erro ao buscar dados do usuario logado");
    }
  }
}
