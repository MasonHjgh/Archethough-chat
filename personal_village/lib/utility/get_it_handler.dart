import 'package:get_it/get_it.dart';
import 'package:personal_village/utility/dio_manager.dart';
import 'package:personal_village/utility/logic/app_logic.dart';
import 'package:personal_village/utility/logic/settings_logic.dart';
import 'package:personal_village/utility/navigation_service.dart';

GetIt pvLocator = GetIt.instance;

setupGetIt() {
  GetIt.I.registerLazySingleton<NavigationService>(() => NavigationService());
  GetIt.I.registerLazySingleton<DioManager>(() => DioManager());
  GetIt.I.registerLazySingleton<SettingsLogic>(() => SettingsLogic());
  GetIt.I.registerLazySingleton<AppLogic>(() => AppLogic());
}

NavigationService get pvNavService => GetIt.I.get<NavigationService>();
DioManager get pvDioManager => GetIt.I.get<DioManager>();
SettingsLogic get pvSettingsLogic => GetIt.I.get<SettingsLogic>();
AppLogic get pvAppLogic => GetIt.I.get<AppLogic>();
