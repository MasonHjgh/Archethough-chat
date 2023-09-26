import 'package:flutter/material.dart';

class NavigationService<T, U> {
  static GlobalKey<NavigatorState> pvNavKey = GlobalKey<NavigatorState>();

  Future<T?> pushNamed(String routeName, {Object? args}) async {
    return await pvNavKey.currentState!.pushNamed<T>(
      routeName,
      arguments: args,
    );
  }

  Future<T?> push(Route<T> route) async {
    return await pvNavKey.currentState!.push<T>(route);
  }

  Future<T?> pushReplacementNamed(String routeName, {Object? args}) async {
    return await pvNavKey.currentState!.pushReplacementNamed<T, U>(
      routeName,
      arguments: args,
    );
  }

  Future<T?> pushNamedAndRemoveUntil(String routeName, {Object? args}) async {
    return await pvNavKey.currentState!.pushNamedAndRemoveUntil<T>(
      routeName,
      (Route<dynamic> route) => false,
      arguments: args,
    );
  }

  Future<T?> pushNamedAndRemoveUntilWithRoute(String routeName,
      {Object? args}) async {
    return await pvNavKey.currentState!.pushNamedAndRemoveUntil<T>(
      routeName,
      (Route<dynamic> route) =>
          route.isCurrent && route.settings.name == routeName ? false : true,
      arguments: args,
    );
  }

  Future<bool> maybePop([Object? args]) async {
    return await pvNavKey.currentState!.maybePop<bool>(args as bool?);
  }

  bool canPop() => pvNavKey.currentState!.canPop();

  void goBack({T? result}) => pvNavKey.currentState!.pop<T>(result);

  void pop() => pvNavKey.currentState!.pop();
}
