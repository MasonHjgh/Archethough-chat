import 'package:flutter/foundation.dart';
import 'package:personal_village/models/common/user.dart';
import 'package:personal_village/utility/logic/core/throttle_save_load_mixin.dart';

class SettingsLogic with ThrottledSaveLoadMixin {
  @override
  String get fileName => 'settings.dat';

  late final hasCompletedOnboarding = ValueNotifier<bool>(false)
    ..addListener(scheduleSave);
  late final currentUserInfo = ValueNotifier<User>(User.empty)
    ..addListener(scheduleSave);

  @override
  void copyFromJson(Map<String, dynamic> value) {
    hasCompletedOnboarding.value = value['hasCompletedOnboarding'] ?? false;
    currentUserInfo.value = User.fromJson(value['userInfo']);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'hasCompletedOnboarding': hasCompletedOnboarding.value,
      'userInfo': currentUserInfo.value.toJson()
    };
  }
}
