import 'package:flutter/material.dart';
import 'package:firstflutterapp/src/views/ui/LoginPage.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
