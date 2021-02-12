import 'dart:ui';

import 'package:flutter/material.dart';

import '../route.dart';

class SignIn extends StatelessWidget {

  String email = '';
  String password = '';
  final formKey = new GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        visualContainer(),
        mainContainer(context),
      ],
    );
  }

  Widget visualContainer() {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('Assets/image1.png'),
              fit: BoxFit.fitWidth,
              alignment: Alignment.topCenter
          )
      ),
    );
  }

  Widget mainContainer(BuildContext context) {
    return  Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(top: 300),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: Padding(
          padding: EdgeInsets.fromLTRB(35, 0, 35, 35),
          child: Form(
            key: formKey,
            child: ListView(
              children: <Widget>[
                signInTextField(),
                emailTextField(),
                passwordTextField(),
                signInButton(context),
                forgotpasswordTextField(),
                signupTextField()
              ],
            ),
          )
      ),
    );
  }

  Widget signInTextField() {
    return Container(
      child: RichText(
        text: TextSpan(
            text: "Sign In",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'Tomorrow',
              color: Colors.black,
              fontSize: 40,
            )
        ),
      ),
    );
  }
  
  Widget emailTextField() {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
      child: Container(
        color: Color(0xfff5f5f5),
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
    return Container(
      color: Color(0xfff5f5f5),
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
    return Padding(
      padding: EdgeInsets.only(top: 40),
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
        height: 50,
        textColor: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
        ),
      ),
    );
  }

  Widget forgotpasswordTextField() {
    return Padding(
      padding: EdgeInsets.only(top: 70),
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
      padding: EdgeInsets.only(top: 70),
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

