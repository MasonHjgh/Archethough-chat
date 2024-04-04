import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:personal_village/models/common/user.dart';
import 'package:personal_village/repositories/auth/authentication_repo_interface.dart';
import 'package:personal_village/utility/get_it_handler.dart';
import 'package:personal_village/values/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationRepository extends IAuthRepository {
  User? _user;
  final _controller = StreamController<AuthenticationStatus>();

  AuthenticationRepository(super.dioManager);

  Stream<AuthenticationStatus> get status async* {
    //TODO: Update fetching local current user status from here + token
    await Future<void>.delayed(const Duration(seconds: 3));
    yield AuthenticationStatus.unauthenticated;
    yield* _controller.stream;
  }

  // Future<bool> logIn({
  //   required String username,
  //   required String password,
  // }) async {
  //   // var response = await dioManager.dio.post("/");
  //   await Future.delayed(
  //     const Duration(milliseconds: 300),
  //     () {
  //       // print(apiUrl);
  //       // final response = await http.post
  //       // if (response.statusCode == 200) {
  //       // // Request successful, parse response data
  //       // print(response.body);
  //       // } else {
  //       // // Request failed
  //       // print('Failed to fetch data: ${response.statusCode}');
  //       // }
  //       // if (username == "john" && password == "john123") {
  //       //   _controller.add(AuthenticationStatus.authenticated);
  //       //   _user = User("123", username: "John");
  //       //   setCurrentUser();
  //       //   return true;
  //       // } else {
  //       //   _controller.add(AuthenticationStatus.unauthenticated);
  //       //   return false;
  //       // }
  //     },
  //   );
  //   return false;
  // }


Future<bool> logIn({
  required String username,
  required String password,
}) async {
  // Encode the login data as JSON
  String jsonData = jsonEncode({
    'username': username,
    'password': password,
  });
  String loginurl=apiUrl+"/credential/login";
  try {
    final response = await http.post(
      Uri.parse(loginurl),
      headers: <String, String>{
        'accept': 'application/json',
        'Content-Type': 'application/json'
      },
      body: jsonData,
    );

    if (response.statusCode == 200) {
      // Login successful
          print(response);
          final data = jsonDecode(response.body);
          _user=User.fromJson(data);
          // _user = User("123", username: );
          setCurrentUser();
          _controller.add(AuthenticationStatus.authenticated);
      return true;
    } else {
      // Login failed
      _controller.add(AuthenticationStatus.unauthenticated);
      return false;
    }
  } catch (error) {
    // Handle errors
    print('Error logging in: $error');
    return false;
  }
}


  void logOut() {
 
    print("hello");
 
    _controller.add(AuthenticationStatus.unauthenticated);
    clearUser();

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
    _user=User.empty;
  throw UnimplementedError;
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
