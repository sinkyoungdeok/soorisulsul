import 'package:flutter/material.dart';
import 'package:soorisulsul/screen/Main.dart';
import 'package:soorisulsul/screen/signIn.dart';


class SignInRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SignIn(),
    );
  }
}

class MainRoute extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Main(),
    );
  }
}
