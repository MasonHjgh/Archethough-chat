import 'package:flutter/material.dart';
import 'package:personal_village/values/routes.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Center(
          child: Text(
            'Welcome to Your Village',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        // Add an image/logo to the AppBar
      ),
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: Image.asset(
                  'assets/villageLogo.png', // Change this to the path of your image asset
                  width: 400.0, // Adjust the width as needed
                  height: 400.0, // Adjust the height as needed
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // TODO: Handle sign-in button click
                  Navigator.pushNamed(context, homeRoute); // Navigate to the home route
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[100],
                ), // Set the button's background color
                child: Text(
                  'Sign In',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // TODO: Handle sign-up button click
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[100],
                ), // Set the button's background color
                child: Text(
                  'Sign Up',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  // TODO: Handle forgot password button click
                },
                child: Text(
                  'Forgot Password?',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
