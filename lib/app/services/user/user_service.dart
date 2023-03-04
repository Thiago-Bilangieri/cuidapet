import 'package:cuida_pet/app/models/user_model.dart';

abstract class UserService {
  Future<void> register(String email, String password);
  Future<void> login(String email, String password);
  // Future<UserModel> getUserLogged
}
