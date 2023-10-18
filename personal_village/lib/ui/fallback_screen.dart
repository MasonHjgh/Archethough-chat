import 'package:flutter/material.dart';

class FallbackScreen extends StatelessWidget {
  const FallbackScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
            "Oh! You weren't supposed to come here. Lets get you back on track"),
      ),
    );
  }
}
