import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_village/login/bloc/login_bloc.dart';
import 'package:personal_village/login/view/login_form.dart';
import 'package:personal_village/repositories/auth/authentication_repository.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Center(
          child: Text(
            'Welcome to Your Village',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        // Add an image/logo to the AppBar
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: BlocProvider(
          create: (context) {
            return LoginBloc(
              authenticationRepository:
                  RepositoryProvider.of<AuthenticationRepository>(context),
            );
          },
          child: const LoginForm(),
        ),
      ),
    );
  }
}
