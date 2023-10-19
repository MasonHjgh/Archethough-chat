import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:personal_village/models/common/user.dart';
import 'package:personal_village/repositories/auth/authentication_repo_interface.dart';
import 'package:personal_village/utility/get_it_handler.dart';

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

  Future<bool> logIn({
    required String username,
    required String password,
  }) async {
    // var response = await dioManager.dio.post("/");
    await Future.delayed(
      const Duration(milliseconds: 300),
      () {
        if (username == "john" && password == "john123") {
          _controller.add(AuthenticationStatus.authenticated);
          _user = User("123", username: "John");
          setCurrentUser();
          return true;
        } else {
          _controller.add(AuthenticationStatus.unauthenticated);
          return false;
        }
      },
    );
    return false;
  }

  void logOut() {
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  //TODO: Handle getting the locally stored details of the logged in user.
  @override
  Future<User?> getUser() async {
    if (_user != null) return _user!;
    User localCachedUser = pvSettingsLogic.currentUserInfo.value;
    print("What is this $localCachedUser");
    if (localCachedUser != User.empty) {
      _user = localCachedUser;
      _controller.add(AuthenticationStatus.authenticated);
      return _user!;
    }
    return null;
  }

  @override
  Future<void> clearUser() {
    // TODO: implement clearing up the user when the user logs out.
    throw UnimplementedError();
  }

  @override
  Future<void> setCurrentUser() async {
    // TODO: implement setCurrentUser when the user logs in
    if (_user == null) return;
    try {
      if (_user == User.empty) return;
      print("Do we reach here?");
      pvSettingsLogic.currentUserInfo.value = _user!;
      print("What is the value now? ${pvSettingsLogic.currentUserInfo.value}");
    } catch (e) {
      debugPrint("Error storing local user");
    }
  }

  void dispose() => _controller.close();
}
