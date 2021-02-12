import 'package:flutter/material.dart';
import 'package:soorisulsul/screen/Main.dart';
import 'package:soorisulsul/screen/SignIn.dart';


class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SignIn(),
    );
  }
}

class SecondRoute extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MyApp(),
    );
  }
}
