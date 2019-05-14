import 'package:flutter/material.dart';
import 'auth.dart';
import 'login.dart';
import 'home.dart';

class Rootpage extends StatefulWidget {

  Rootpage({this.auth});
  final BaseAuth auth;

  @override
  State<StatefulWidget> createState() => _RootPageState();
}

enum AuthStatus{
  notSignedIn,
  signedIn
}

class _RootPageState extends State<Rootpage>{

  AuthStatus authStatus = AuthStatus.notSignedIn;

  @override
  void initState() {
    super.initState();
    widget.auth.currentUser().then((userId) {
      setState(() {
        authStatus = userId == null ? AuthStatus.notSignedIn : AuthStatus.signedIn;
      });
    });
  }

  void _signedIn() {
    setState(() {
      authStatus = AuthStatus.signedIn;
    });
  }

  void _signedOut() {
    setState(() {
      authStatus = AuthStatus.notSignedIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (authStatus){
      case AuthStatus.notSignedIn:
        return Login(auth: widget.auth, onSignedIn: _signedIn);
      case AuthStatus.signedIn:
        return Home(auth: widget.auth, onSignedOut: _signedOut);
    }
  }

}