import 'package:flutter/foundation.dart';
import 'package:personal_village/utility/logic/core/throttle_save_load_mixin.dart';
import 'package:personal_village/utility/platform_info.dart';

class SettingsLogic with ThrottledSaveLoadMixin {
  @override
  String get fileName => 'settings.dat';

  late final hasCompletedOnboarding = ValueNotifier<bool>(false)
    ..addListener(scheduleSave);

  final bool useBlurs = !PlatformInfo.isAndroid;

  @override
  void copyFromJson(Map<String, dynamic> value) {
    hasCompletedOnboarding.value = value['hasCompletedOnboarding'] ?? false;
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'hasCompletedOnboarding': hasCompletedOnboarding.value,
    };
  }
}
