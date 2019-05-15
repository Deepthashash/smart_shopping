import 'package:flutter/material.dart';

//pages
import './app_screens/login.dart';
import './app_screens/signup.dart';
import './app_screens/home.dart';
import './app_screens/auth.dart';
import './app_screens/root.dart';

void main(){
  runApp( MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Go Flutter",
      home:Rootpage(auth: Auth()),
      theme: ThemeData(
        brightness: Brightness.dark
      ),
      routes: <String, WidgetBuilder> {
          '/landingpage': (BuildContext context)=> MyApp(),
          '/login': (BuildContext context)=> Login(auth: Auth()),
          '/signup': (BuildContext context)=> Signup(auth: Auth()),
          '/home': (BuildContext context)=> Home(),
        }
    );
  }

}

