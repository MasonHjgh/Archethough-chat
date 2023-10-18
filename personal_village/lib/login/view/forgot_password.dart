import 'package:flutter/material.dart';



class ForgotPasswordView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Icon(
                Icons.lock_outline,//
                color: Colors.white, //
              ),
              SizedBox(width: 8), //
              Text(
                'Forgot Password',
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
          backgroundColor: Colors.orange,
        ),
        body: ForgotPasswordForm(),
      );
  }
}

class ForgotPasswordForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Enter your email to reset your password',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 20),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Email',
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Implement the password reset logic here
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.blueGrey),
            ),
            child: Text('Reset Password'),
          ),
        ],
      ),
    );
  }
}
