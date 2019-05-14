import 'auth.dart';
import 'package:flutter/material.dart';

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

  bool validatenSave(){
    final form = formkey.currentState;
    if(form.validate()){
      form.save();
      print("$_email $_password");
      return true;
    }else{
      return false;
    }
  }

  void validatenSubmit() async{
    print("Hello");
    if(validatenSave()){
      try{
        String userId = await widget.auth.signUp(_email, _password);
        print("signed in: $userId");
        widget.onSignedIn();
        //Navigator.of(context).pushNamed('/home');
      }catch(e){
        print("Error $e");
      }
    }else print("error");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(title: Text("Keells"), backgroundColor: Colors.greenAccent,),
      body: Center(
        child: Form(
          key: formkey,
        child:ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(25.0),
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(hintText: 'Enter profile name'),
              validator: (value) => value.isEmpty ? "Email can't be empty" : null,
              onSaved: (value) => _email = value ,
            ),
            SizedBox(height: 15.0),
            TextFormField(
              obscureText: true,
              decoration: InputDecoration(hintText: 'Enter password'),
              validator: (value) => value.length < 6 ? "password should atleast six figures long" : null,
              onSaved: (value) => _password = value ,
            ),
            SizedBox(height: 15.0),
            RaisedButton(
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
              child: Text("Back to Login"),
              color: Colors.greenAccent,
              textColor: Colors.white,
              highlightColor: Colors.black,
              elevation: 6.0,
              onPressed: () {
                Navigator.of(context).pushNamed('/login');
              }
            ),
            SizedBox(height: 15.0),],
)
      )));
  }

            
            
}
        
      

