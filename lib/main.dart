import 'package:flutter/material.dart';
import 'route.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SignInRoute(),
      debugShowCheckedModeBanner: false,
    );
  }
}
