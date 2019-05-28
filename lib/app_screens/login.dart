import 'auth.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  Login({this.auth, this.onSignedIn});

  final BaseAuth auth;
  final VoidCallback onSignedIn;

  @override
  State<StatefulWidget> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formkey = GlobalKey<FormState>();

  String _email;
  String _password;

  bool validatenSave() {
    final form = formkey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  void validatenSubmit() async {
    if (validatenSave()) {
      try {
        String userId = await widget.auth.signIn(_email, _password);
        print("signed in: $userId");
        widget.onSignedIn();
        // Navigator.of(context).pushNamed('/home');
      } catch (e) {
        print("Error $e");
      }
    }
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
                      decoration: InputDecoration(hintText: 'Enter your email'),
                      validator: (value) =>
                          value.isEmpty ? "Email can't be empty" : null,
                      onSaved: (value) => _email = value,
                    ),
                    SizedBox(height: 15.0),
                    TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(hintText: 'Enter password'),
                      validator: (value) =>
                          value.isEmpty ? "password can't be empty" : null,
                      onSaved: (value) => _password = value,
                    ),
                    SizedBox(height: 15.0),
                    RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0)),
                        elevation: 6.0,
                        child: Text("Login"),
                        color: Colors.greenAccent,
                        textColor: Colors.white,
                        highlightColor: Colors.black,
                        onPressed: validatenSubmit),
                    SizedBox(height: 15.0),
                    Text("Don't have an account"),
                    RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0)),
                        child: Text("Signup"),
                        color: Colors.greenAccent,
                        textColor: Colors.white,
                        highlightColor: Colors.black,
                        elevation: 6.0,
                        onPressed: () {
                          Navigator.of(context).pushNamed('/signup');
                        }),
                    SizedBox(height: 15.0),
                  ],
                ))));
  }
}
