import 'package:flutter/painting.dart';

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
  Services ser = Services();
  String _name;
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
        ser.createData(_name, _nic, _nexus, userId, _email);
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
          body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage("assets/images/image4.jpg"),
          fit: BoxFit.cover,
        )),
        child: Center(
            child: Form(
                key: formkey,
                child: ListView(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(25.0),
                  children: <Widget>[
                    SizedBox(
                      height: 55,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        // icon: Icon(Icons.email),
                        hintText: 'Enter your email',
                        labelText: 'Email',
                        hasFloatingPlaceholder: true,
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.blueAccent,
                            width: 4,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.red,
                            width: 4,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.lightBlueAccent,
                            width: 4,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.blueGrey,
                            width: 4,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                        ),
                        border: UnderlineInputBorder(),
                      ),
                      cursorColor: Colors.white,
                      validator: (value) =>
                          value.isEmpty ? "Email can't be empty" : null,
                      onSaved: (value) => _email = value,
                    ),
                    SizedBox(height: 25.0),
                    TextFormField(
                      cursorColor: Colors.white,
                      obscureText: true,
                      decoration: const InputDecoration(
                        // icon: Icon(Icons.security),
                        hintText: 'Enter your password',
                        labelText: 'Password',
                        hasFloatingPlaceholder: true,
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.blueAccent,
                            width: 4,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.red,
                            width: 4,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.lightBlueAccent,
                            width: 4,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.blueGrey,
                            width: 4,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                        ),
                        border: UnderlineInputBorder(),
                      ),
                      validator: (value) =>
                          value.isEmpty ? "password can't be empty" : null,
                      onSaved: (value) => _password = value,
                    ),
                    SizedBox(height: 45.0),
                    Container(
                      padding: EdgeInsets.only(left: 75.0,right: 75.0),
                      child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0)),
                          elevation: 6.0,
                          child: Text("Login",),
                          color: Colors.teal,
                          textColor: Colors.white,
                          highlightColor: Colors.black,
                          onPressed: () => validatenSubmit(context)),
                    ),
                    SizedBox(height: 10.0),
                    Container(
                      padding: EdgeInsets.only(left: 75.0,right: 75.0),
                      child:RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                        child: Text("Signup"),
                        color: Colors.teal,
                        textColor: Colors.white,
                        highlightColor: Colors.black,
                        elevation: 6.0,
                        onPressed: () {
                          moveSignup();
                        })),
                    SizedBox(height: 15.0),
                  ],
                ))),
      ));
    } else {
      return Scaffold(
          appBar: AppBar(
            title: Text("SmartMart"),
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
                        decoration: InputDecoration(
                          hintText: 'Enter Name',
                          ),
                        validator: (value) =>
                            value.isEmpty ? "Name can't be empty" : null,
                        onSaved: (value) => _name = value,
                      ),
                      SizedBox(height: 15.0),
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
                            borderRadius: BorderRadius.circular(15.0)),
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
                              borderRadius: BorderRadius.circular(15.0)),
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
