import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/all.dart';

import '../route.dart';

class SignIn extends StatefulWidget {
  SignIn({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _KakaoLoginState createState() => _KakaoLoginState();
}

class _KakaoLoginState extends State<SignIn> {
  bool _isKakaoTalkInstalled = false;
  var isSmall = false;
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _initKakaoTalkInstalled();
  }

  _initKakaoTalkInstalled() async {
    final installed = await isKakaoTalkInstalled();
    print('kakao Install : ' + installed.toString());

    setState(() {
      _isKakaoTalkInstalled = installed;
    });
  }

  _issueAccessToken(String authCode) async {
    try {
      var token = await AuthApi.instance.issueAccessToken(authCode);
      AccessTokenStore.instance.toStore(token);
      print(token);
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MainRoute()),
      );
    } catch (e) {
      print("error on issuing access token: $e");
    }
  }

  _loginWithKakao() async {
    try {
      var code = await AuthCodeClient.instance.request();
      await _issueAccessToken(code);
    } catch (e) {
      print(e);
    }
  }

  _loginWithTalk() async {
    try {
      var code = await AuthCodeClient.instance.requestWithTalk();
      await _issueAccessToken(code);
    } catch (e) {
      print(e);
    }
  }

  logOutTalk() async {
    try {
      var code = await UserApi.instance.logout();
      print(code.toString());
    } catch (e) {
      print(e);
    }
  }

  unlinkTalk() async {
    try {
      var code = await UserApi.instance.unlink();
      print(code.toString());
    } catch (e) {
      print(e);
    }
  }



  String email = '';
  String password = '';
  final formKey = new GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    isKakaoTalkInstalled();

    return Stack(
      children: <Widget>[
        visualContainer(),
        mainContainer(context),
      ],
    );
  }

  Widget visualContainer() {
    return Container(
      transform: Matrix4.translationValues(0.0, -5.0, 0.0),

      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('Assets/loginbeer.png'),

              fit: BoxFit.fitWidth,
              alignment: Alignment.topCenter
          )
      ),
    );
  }

  Widget mainContainer(BuildContext context) {

    return  LayoutBuilder(builder: (context, boxConstraints)
    {
      print(isSmall);
      print(boxConstraints.maxHeight);
      if(boxConstraints.maxHeight <= 670){
        print(1);
        isSmall = true;
      }
      print(isSmall);

      return Container(
        width: MediaQuery
            .of(context)
            .size
            .width,
        // margin: EdgeInsets.only(top: isSmall ? 180 : 300),
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.27),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: Padding(
            padding: EdgeInsets.fromLTRB(35, 0, 35, 35),
            child: Form(
              key: formKey,
              child: Column(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Column(
                        children:<Widget>[signInTextField()]
                    ),
                  )


                  ,
                  // emailTextField(),
                  // passwordTextField(),
                  // signInButton(context),
                  Expanded(
                      flex: 5,

                      child: Column(
                          children:<Widget>[kakaoSignInButton(context)]
                      ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Column(
                        children:<Widget>[forgotpasswordTextField(),
                          signupTextField()]
                    ),
                  ),

                ],
              ),
            )
        ),
      );
    }
    );
  }


  Widget signInTextField() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Text(
          "Sign In",
          textAlign: TextAlign.left,



          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'Tomorrow',
              color: Colors.black,
              fontSize: isSmall ? 25 : 40,
          )

      ),
    );
  }

  Widget emailTextField() {
    var myDeviceHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.fromLTRB(0, myDeviceHeight * 0.015, 0, myDeviceHeight * 0.015),
      child: Container(
        color: Color(0xfff5f5f5),
        height: myDeviceHeight * 0.07,
        child: TextFormField(
          onSaved: (val) => email = val,
          style: TextStyle(
              color: Colors.black,
              fontFamily: 'Tomorrow'
          ),
          decoration: InputDecoration(
              border: OutlineInputBorder(),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 0.01),
              ),
              labelText: 'User name',
              prefixIcon: Icon(Icons.person_outline),
              labelStyle: TextStyle(
                  fontSize: 15
              )
          ),

        ),
      ),
    );
  }

  Widget passwordTextField() {
    var myDeviceHeight = MediaQuery.of(context).size.height;
    return Container(
      color: Color(0xfff5f5f5),
      height: myDeviceHeight * 0.07 ,
      child: TextFormField(
        onSaved: (val) => password = val,
        obscureText: true,
        style: TextStyle(
            color: Colors.black,
            fontFamily: 'Tomorrow'
        ),
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 0.01),
            ),
            labelText: 'Password',
            prefixIcon: Icon(Icons.lock_outline),
            labelStyle: TextStyle(
                fontSize: 15
            )
        ),
      ),
    );
  }

  Widget signInButton(BuildContext context) {
    var myDeviceHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.only(top: myDeviceHeight * 0.02),
      child: MaterialButton(
        onPressed: (){
          if (formKey.currentState.validate()) {
            formKey.currentState.save();
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text("test" + email + password),
            ));
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MainRoute()),
            );
          }
        },//since this is only a UI app
        child: Text('SIGN IN',
          style: TextStyle(
            fontSize: 15,
            fontFamily: 'Tomorrow',
            fontWeight: FontWeight.bold,
          ),
        ),
        color: Color(0xffff2d55),
        elevation: 0,
        minWidth: 400,
        height: myDeviceHeight * 0.06,
        textColor: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
        ),
      ),
    );
  }

  Widget kakaoSignInButton(BuildContext context){
    return Padding(
        padding: EdgeInsets.only(top: 20),
        child: InkWell (
          onTap: () => _isKakaoTalkInstalled? _loginWithTalk() : _loginWithKakao(),
          child: Container(
              width: MediaQuery.of(context).size.width * 1,
              height: MediaQuery.of(context).size.height * 0.05,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.yellow
              ),
              child :Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.chat_bubble, color: Colors.black54),
                  SizedBox(width: 10,),
                  Text(
                    '카카오계정 로그인',
                    style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.w900,
                        fontSize: 20
                    ),
                  ),
                ],
              )
          ),
        )
    );
  }

  Widget forgotpasswordTextField() {
    return Padding(
      padding: EdgeInsets.only(top: isSmall ? 20 : 50),
      child: Center(
        child: Text('Forgot your password?',
          style: TextStyle(
              fontFamily: 'Tomorrow',
              fontSize: 15,
              fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
  }

  Widget signupTextField() {
    return Padding(
      padding: EdgeInsets.only(top: isSmall ? 20 :50),
      child: Center(
        child: RichText(
          text: TextSpan(
              children: [
                TextSpan(
                    text: "Don't have an account?",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Tomorrow',
                      color: Colors.black,
                      fontSize: 15,
                    )
                ),
                TextSpan(
                    text: " Sign up",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Tomorrow',
                      color: Color(0xffff2d55),
                      fontSize: 15,
                    )
                )
              ]
          ),
        ),
      ),
    );
  }



}