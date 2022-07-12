import 'package:flutter/material.dart';

import '../base/baseauth.dart';
import 'loginsignoutpage.dart';
import 'loginsignuppage.dart';

class RootPage extends StatefulWidget {
  RootPage({Key? key, required this.auth});

  final BaseAuth auth;

  @override
  State<StatefulWidget> createState() => _RootPageState();
}

enum AuthStatus {
  NOT_DETERMINED,
  LOGGED_OUT,
  LOGGED_IN,
}

class _RootPageState extends State<RootPage> {

  AuthStatus authStatus = AuthStatus.NOT_DETERMINED;
  String _userId = "";

  @override
  void initState() {
    super.initState();
    widget.auth.getCurrentUser().then((user) {
      setState(() {
        if (user != null) {
          _userId = user.uid;
        }
        authStatus = user?.uid == null ? AuthStatus.LOGGED_OUT : AuthStatus.LOGGED_IN;
      });
    });
  }

  void _onLoggedIn() {
    widget.auth.getCurrentUser().then((user) {
      setState(() {
        _userId = user!.uid;
      });
    });
    setState(() {
      authStatus = AuthStatus.LOGGED_IN;
    });
  }

  void _onSignedOut() {
    setState(() {
      authStatus = AuthStatus.LOGGED_OUT;
      _userId = "";
    });
  }

  Widget progressScreenWidget() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  @override
  Widget build(BuildContext context) {
    switch (authStatus) {
      case AuthStatus.NOT_DETERMINED:
        return progressScreenWidget();
        break;

      case AuthStatus.LOGGED_OUT:
        if (_userId.length > 0 && _userId.isNotEmpty) {
          return LoginSignOutPage(
            userId: _userId,
            auth: widget.auth,
            onSignedOut: _onSignedOut,
          );
        } else
          return progressScreenWidget();
        break;

      case AuthStatus.LOGGED_IN:
        return LoginSignupPage(
          auth: widget.auth,
          onSignedIn: _onLoggedIn,
        );
        break;

      default :
        return progressScreenWidget();
    }
  }

}