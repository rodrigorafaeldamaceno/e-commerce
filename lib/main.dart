import 'package:ecommerce/screens/LoginScreen.dart';
import 'package:ecommerce/screens/RegisterScreen.dart';
import 'package:flutter/material.dart';

import 'package:ecommerce/screens/HomeScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-Commerce',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Colors.cyan[400]//Color.fromARGB(255, 4, 125, 141)
      ),
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
