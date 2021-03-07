import 'package:flutter/material.dart';
import 'route.dart';
import 'package:kakao_flutter_sdk/all.dart';


void main() {
  KakaoContext.clientId = "290ab37602446d68812d6c42fad5c7fa";
  KakaoContext.javascriptClientId = "143d3d89bf511eff2cd9dcdb923d6826";
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SignInRoute(),
      debugShowCheckedModeBanner: false,
    );
  }
}
