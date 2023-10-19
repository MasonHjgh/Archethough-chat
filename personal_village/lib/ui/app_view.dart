import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_village/authentication/authentication.dart';
import 'package:personal_village/repositories/auth/authentication_repository.dart';
import 'package:personal_village/utility/get_it_handler.dart';
import 'package:personal_village/utility/router.dart';
import 'package:personal_village/values/routes.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final AuthenticationRepository _authenticationRepository;

  @override
  void initState() {
    super.initState();
    _authenticationRepository = AuthenticationRepository(pvDioManager);
    _authenticationRepository.getUser();
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => _authenticationRepository),
      ],
      child: BlocProvider(
        create: (_) => AuthenticationBloc(
            authenticationRepository: _authenticationRepository),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          onGenerateRoute: generateRoute,
          navigatorKey: pvNavService.pvNavKey,
          builder: (context, child) {
            return BlocListener<AuthenticationBloc, AuthenticationState>(
              listener: (context, state) {
                switch (state.status) {
                  case AuthenticationStatus.authenticated:
                    pvNavService.pushNamedAndRemoveUntil(dashboardRoute);
                    break;
                  case AuthenticationStatus.unauthenticated:
                    if (pvSettingsLogic.hasCompletedOnboarding.value) {
                      pvNavService.pushNamedAndRemoveUntil(loginRoute);
                    } else {
                      pvNavService.pushNamedAndRemoveUntil(onboardingRoute);
                    }
                    break;
                  case AuthenticationStatus.unknown:
                    pvNavService.pushNamedAndRemoveUntil(loginRoute);
                    break;
                }
              },
              child: child,
            );
          },
        ),
      ),
    );
  }
}
