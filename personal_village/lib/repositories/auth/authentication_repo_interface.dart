import 'package:personal_village/models/common/user.dart';
import 'package:personal_village/utility/dio_manager.dart';

abstract class IAuthRepository {
  final DioManager dioManager;

  IAuthRepository(this.dioManager);

  Future<dynamic> logIn({
    required String username,
    required String password,
  });
  void logOut();

  Future<User> getUser();

  Future<void> clearUser();

  Future<void> setCurrentUser();
}
