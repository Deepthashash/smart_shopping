import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'auth.dart';

class Home extends StatelessWidget {

  Home({this.auth, this.onSignedOut});
  final BaseAuth auth;
  final VoidCallback onSignedOut;

  Future _signOut() async {
    try{
      await auth.signOut();
      onSignedOut();
    }catch(e){
      print(e);
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      backgroundColor: Colors.greenAccent,
      title: Text("Welcome to Keells"),
      actions: <Widget>[
        RaisedButton(
          color: Colors.green,
          elevation: 1.0,
          child: Text("SignOut"),
          onPressed: _signOut,
        )
      ],
    ),);
  }

}