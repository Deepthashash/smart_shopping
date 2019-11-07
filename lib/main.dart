import 'package:flutter/material.dart';

//pages
import './app_screens/login.dart';
import './app_screens/home.dart';
import './app_screens/auth.dart';
import './app_screens/root.dart';
import './app_screens/billing.dart';
import './app_screens/profile.dart';
import './app_screens/cartItems.dart';
import './app_screens/rating.dart';


void main(){
  runApp( MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Smart Shopping",
      home:Rootpage(auth: Auth()),
      theme: ThemeData(
        brightness: Brightness.light
      ),
      routes: <String, WidgetBuilder> {
          '/landingpage': (BuildContext context)=> MyApp(),
          '/login': (BuildContext context)=> Login(auth: Auth()),
          '/home': (BuildContext context)=> Home(),
          '/billing': (BuildContext context)=> Billing(),
          '/profile': (BuildContext context)=> Profile(),
          '/cart': (BuildContext context)=> CartItems(),
          '/rating': (BuildContext context)=> Rating(),
        }
    );
  }

}

