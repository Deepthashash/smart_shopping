import 'auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Signup extends StatefulWidget {
  Signup({this.auth, this.onSignedIn});

  final BaseAuth auth;
  final VoidCallback onSignedIn;

  @override
  State<StatefulWidget> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final formkey = GlobalKey<FormState>();

  String _email;
  String _password;
  String _nic;
  String _nexus;

  bool validatenSave() {
    final form = formkey.currentState;
    if (form.validate()) {
      form.save();
      print("$_email $_password");
      return true;
    } else {
      return false;
    }
  }

  void validatenSubmit() async {
    print("Hello");
    if (validatenSave()) {
      try {
        String userId = await widget.auth.signUp(_email, _password);
        // await widget.auth.userinfo(_nexus,_nic);
        print("signed in: $userId");
        createData(_nic, _nexus, userId);
        Navigator.of(context).pushNamed('/home');
      } catch (e) {
        print("Error $e");
      }
    } else
      print("error");
  }

  createData(_nic, _nexus, userId) {
    DocumentReference docref = Firestore.instance.document("Data/userData");
    Map<String, dynamic> details = {
      "userId": userId,
      "NIC": _nic,
      "Nexus": _nexus
    };
    docref.setData(details).whenComplete(() {
      print("done");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Keells"),
          backgroundColor: Colors.greenAccent,
        ),
        body: Center(
            child: Form(
                key: formkey,
                child: ListView(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(25.0),
                  children: <Widget>[
                    TextFormField(
                      decoration:
                          InputDecoration(hintText: 'Enter profile name'),
                      validator: (value) =>
                          value.isEmpty ? "Email can't be empty" : null,
                      onSaved: (value) => _email = value,
                    ),
                    SizedBox(height: 15.0),
                    TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(hintText: 'Enter password'),
                      validator: (value) => value.length < 6
                          ? "password should atleast six figures long"
                          : null,
                      onSaved: (value) => _password = value,
                    ),
                    SizedBox(height: 15.0),
                    TextFormField(
                      decoration: InputDecoration(hintText: 'Enter your NIC'),
                      validator: (value) =>
                          value.isEmpty ? "NIC can't be empty" : null,
                      onSaved: (value) => _nic = value,
                    ),
                    SizedBox(height: 15.0),
                    TextFormField(
                      decoration:
                          InputDecoration(hintText: 'Enter your Nexus number'),
                      validator: (value) =>
                          value.isEmpty ? "Nexus number can't be empty" : null,
                      onSaved: (value) => _nexus = value,
                    ),
                    SizedBox(height: 15.0),
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0)),
                      elevation: 6.0,
                      child: Text("Signup"),
                      color: Colors.greenAccent,
                      textColor: Colors.white,
                      highlightColor: Colors.black,
                      onPressed: validatenSubmit,
                    ),
                    SizedBox(height: 15.0),
                    Text("Don't have an account"),
                    RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0)),
                        child: Text("Back to Login"),
                        color: Colors.greenAccent,
                        textColor: Colors.white,
                        highlightColor: Colors.black,
                        elevation: 6.0,
                        onPressed: () {
                          Navigator.of(context).pushNamed('/login');
                        }),
                    SizedBox(height: 15.0),
                  ],
                ))));
  }
}
