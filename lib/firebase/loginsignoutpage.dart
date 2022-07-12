import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_practice/set.dart';
import '../base/baseauth.dart';

Set set = Set();

class LoginSignOutPage extends StatefulWidget {
  LoginSignOutPage({Key? key, required this.auth, required this.userId, required this.onSignedOut}) : super (key: key);

  final BaseAuth auth;
  final VoidCallback onSignedOut;
  final String userId;

  @override
  State<LoginSignOutPage> createState() => LoginSignOutPageState();
}

class LoginSignOutPageState extends State<LoginSignOutPage> with WidgetsBindingObserver, TickerProviderStateMixin{

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FlatButton(
              child: Text( '登出' , style: TextStyle(fontSize: 17.0 , color: Colors.white)),
              onPressed: _signOut
          ),
          Center(
            child: Text( "Hello World!" ),
          ),
        ],
      ),
    );
  }

  void _signOut() async{
    try {
      await widget.auth.signOut();
      widget.onSignedOut();
    } catch (e) {
      print(e);
    }
  }

}