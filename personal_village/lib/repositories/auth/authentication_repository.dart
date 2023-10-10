import 'dart:async';

import 'package:personal_village/models/common/user.dart';
import 'package:personal_village/repositories/auth/authentication_repo_interface.dart';
import 'package:uuid/uuid.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationRepository extends IAuthRepository {
  User? _user;
  final _controller = StreamController<AuthenticationStatus>();

  AuthenticationRepository(super.dioManager);

  Stream<AuthenticationStatus> get status async* {
    //TODO: Update fetching local current user status from here + token
    await Future<void>.delayed(const Duration(seconds: 1));
    yield AuthenticationStatus.unauthenticated;
    yield* _controller.stream;
  }

  Future<void> logIn({
    required String username,
    required String password,
  }) async {
    // var response = await dioManager.dio.post("/");
    await Future.delayed(
      const Duration(milliseconds: 300),
      () {
        if (username == "john" && password == "john123") {
          _controller.add(AuthenticationStatus.authenticated);
        } else {
          _controller.add(AuthenticationStatus.unauthenticated);
        }
      },
    );
  }

  void logOut() {
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  //TODO: Handle getting the locally stored details of the logged in user.
  @override
  Future<User> getUser() async {
    if (_user != null) return _user!;
    return Future.delayed(
      const Duration(milliseconds: 300),
      () => _user = User(const Uuid().v4(), username: "John Doe"),
    );
  }

  @override
  Future<void> clearUser() {
    // TODO: implement clearing up the user when the user logs out.
    throw UnimplementedError();
  }

  @override
  Future<void> setCurrentUser() {
    // TODO: implement setCurrentUser when the user logs in
    throw UnimplementedError();
  }

  void dispose() => _controller.close();
}
