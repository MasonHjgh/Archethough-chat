import 'package:get_it/get_it.dart';
import 'package:personal_village/utility/dio_manager.dart';
import 'package:personal_village/utility/navigation_service.dart';

GetIt pvLocator = GetIt.instance;

setupGetIt() {
  GetIt.I.registerLazySingleton<NavigationService>(() => NavigationService());
  GetIt.I.registerLazySingleton<DioManager>(() => DioManager());
}

NavigationService get pvNavService => GetIt.I.get<NavigationService>();
DioManager get pvDioManager => GetIt.I.get<DioManager>();
