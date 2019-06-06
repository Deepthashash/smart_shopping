import 'auth.dart';
import 'package:flutter/material.dart';
import 'services.dart';

class Login extends StatefulWidget {
  Login({this.auth, this.onSignedIn});

  final BaseAuth auth;
  final VoidCallback onSignedIn;

  @override
  State<StatefulWidget> createState() => _LoginState();
}

enum FormType { login, signup }

class _LoginState extends State<Login> {
  final formkey = GlobalKey<FormState>();
  Services ser = new Services();
  String _email;
  String _password;
  String _nic;
  String _nexus;
  FormType _formType = FormType.login;

  bool validatenSave() {
    final form = formkey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  void moveSignup() {
    setState(() {
      _formType = FormType.signup;
    });
  }

  void moveLogin() {
    setState(() {
      _formType = FormType.login;
    });
  }

  void validatenSubmit(context) async {
    if (validatenSave()) {
      try {
        String userId = await widget.auth.signIn(_email, _password);
        print("signed in: $userId");
        widget.onSignedIn();
        // Navigator.of(context).pushNamed('/home');
      } catch (e) {
        print("Error $e");
        showDialog(
            context: context,
            builder: (context) => Card(
                    child: Container(
                      child: Center(
                  child: Column(
                    children: <Widget>[
                      Text("Error ${e.toString()}"),
                      RaisedButton(
                        child: Text('Ok'),
                        onPressed: () => Navigator.pop(context),
                      )
                    ],
                  ),
                ))));
      }
    }
  }

  void validatenSubmit2() async {
    if (validatenSave()) {
      try {
        String userId = await widget.auth.signUp(_email, _password);
        print("signed in: $userId");
        ser.createData(_nic, _nexus, userId,_email);
        widget.onSignedIn();
      } catch (e) {
        print("Error $e");
        showDialog(
            context: context,
            builder: (context) => Card(
                    child: Container(
                      child: Center(
                  child: Column(
                    children: <Widget>[
                      Text("Error ${e.toString()}"),
                      RaisedButton(
                        child: Text('Ok'),
                        onPressed: () => Navigator.pop(context),
                      )
                    ],
                  ),
                ))));
      }
    } else
      print("error");
  }

  @override
  Widget build(BuildContext context) {
    if (_formType == FormType.login) {
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
                            InputDecoration(hintText: 'Enter your email'),
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
                          onPressed: () => validatenSubmit(context)),
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
                            moveSignup();
                          }),
                      SizedBox(height: 15.0),
                    ],
                  ))));
    } else {
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
                        decoration: InputDecoration(
                            hintText: 'Enter your Nexus number'),
                        validator: (value) => value.isEmpty
                            ? "Nexus number can't be empty"
                            : null,
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
                        onPressed: validatenSubmit2,
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
                            moveLogin();
                          }),
                      SizedBox(height: 15.0),
                    ],
                  ))));
    }
  }
}
