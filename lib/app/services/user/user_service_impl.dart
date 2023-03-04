// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cuida_pet/app/core/exceptions/failure.dart';
import 'package:cuida_pet/app/core/exceptions/user_exist_exception.dart';
import 'package:cuida_pet/app/core/exceptions/user_not_exist_exception.dart';
import 'package:cuida_pet/app/core/helpers/constants.dart';
import 'package:cuida_pet/app/core/local_storage/local_storage.dart';
import 'package:cuida_pet/app/core/logger/app_logger.dart';
import 'package:cuida_pet/app/core/rest_client/rest_client.dart';
import 'package:cuida_pet/app/repositories/user/user_repository_impl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';

import './user_service.dart';

class UserServiceImpl implements UserService {
  final AppLogger _appLog;
  final UserRepositoryImpl _userRepositoryImpl;
  final LocalStorage _localStorage;
  final LocalSecureStorage _localSecureStorage;
  UserServiceImpl({
    required AppLogger log,
    required LocalSecureStorage localSecureStorage,
    required LocalStorage localStorage,
    required UserRepositoryImpl userRepository,
  })  : _appLog = log,
        _localSecureStorage = localSecureStorage,
        _userRepositoryImpl = userRepository,
        _localStorage = localStorage;

  @override
  Future<void> register(String email, String password) async {
    try {
      final firebaseAuth = FirebaseAuth.instance;
      final userLoggedMethod =
          await firebaseAuth.fetchSignInMethodsForEmail(email);
      if (userLoggedMethod.isNotEmpty) {
        throw UserExistException();
      }
      await _userRepositoryImpl.register(email, password);
      final userRegisterCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      await userRegisterCredential.user?.sendEmailVerification();
    } on FirebaseException catch (e, s) {
      _appLog.error("Erro ao criar usuario no Firebase", e, s);
    }
  }

  @override
  Future<void> login(String email, String password) async {
    try {
      final firebaseAuth = FirebaseAuth.instance;
      final userLoggedMethod =
          await firebaseAuth.fetchSignInMethodsForEmail(email);
      if (!userLoggedMethod.isNotEmpty) {
        throw UserNotExistException(
            message: "Usuario não existe, favor cadastre-se");
      }

      if (userLoggedMethod.contains("password")) {
        final userCredential = await firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password);
        if (!(userCredential.user?.emailVerified ?? false)) {
          userCredential.user?.sendEmailVerification();
          throw Failure(
              message:
                  "E-mail não confirmado, por favor verifique sua caixa de spam");
        }
        final accessToken = await _userRepositoryImpl.login(email, password);
        await _saveAccessToken(accessToken);
        await _confirmLogin();
        await _getUserData();
      } else {
        throw Failure(
            message:
                "Login não pode ser feito por email e senha, por favor utilize outro método");
      }
    } on FirebaseAuthException catch (e, s) {
      _appLog.error(
          "Usuario ou senha inválidos FirebaseAuthError [${e.code}]", e, s);
      throw Failure(message: "Usuario ou senha inválidos");
    }
  }

  Future<void> _saveAccessToken(String accessToken) async => await _localStorage
      .write<String>(Constants.LOCAL_STORAGE_ACCESS_TOKEN, accessToken);

  Future<void> _confirmLogin() async {
    final confirmLoginModel = await _userRepositoryImpl.confirmLogin();
    await _saveAccessToken(confirmLoginModel.accessToken);
    await _localSecureStorage.write(
        Constants.LOCAL_STORAGE_REFRESH_TOKEN, confirmLoginModel.refreshToken);
  }

  Future<void> _getUserData() async {
    final usermodel = await _userRepositoryImpl.getUserLoged();
    await _localStorage.write(
        Constants.LOCAL_STORAGE_USER_LOGGED_DATA, usermodel.toJson());
  }
}
