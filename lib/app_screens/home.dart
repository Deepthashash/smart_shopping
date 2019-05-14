import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'auth.dart';

class Home extends StatelessWidget {

  Home({this.auth, this.onSignedOut});
  final BaseAuth auth;
  final VoidCallback onSignedOut;

  void _signOut(){
    try{

    }catch(e){

    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      title: Text("Welcome to Keells"),
      actions: <Widget>[
        FlatButton(
          child: Text("SignOut"),
          onPressed: _signOut,
        )
      ],
    ),);
  }

}