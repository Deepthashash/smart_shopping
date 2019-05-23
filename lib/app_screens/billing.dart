import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'auth.dart';

class Billing extends StatelessWidget {
//  Home({this.auth, this.onSignedOut});
//
//  final BaseAuth auth;
//  final VoidCallback onSignedOut;
//
//  Future _signOut() async {
//    try {
//      await auth.signOut();
//      onSignedOut();
//    } catch (e) {
//      print(e);
//    }
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.greenAccent,
          title: Text("Billing"),
          actions: <Widget>[
          ],
        ),
        floatingActionButton: FloatingActionButton(
//          mini: true,
          elevation: 12.0,
          onPressed: () {
            //Navigator.of(context).pushNamed('/');
          },
          child: Icon(
            Icons.add,
          ),
          foregroundColor: Colors.white,
          backgroundColor: Colors.greenAccent,
        ),
        body: Material(
        child: Center(
          child: ListView(
            children: <Widget>[
              ListTile(
                leading: Text("Keells"),
                subtitle: Text("hello"),
              ),
              ListTile(
                  title: Text("Your Profile"),
                  onTap: () {
//                    Navigator.of(context).pop();
                  }),
              ListTile(
                  title: Text("Promotions"),
                  onTap: () {
//                    Navigator.of(context).pop();
                  }),
              ListTile(
                  title: Text("Settings"),
                  onTap: () {}),
            ],
          ),
    )));
  }
}