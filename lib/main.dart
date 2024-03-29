import 'package:ecommerce/models/CartModel.dart';
import 'package:ecommerce/models/UserModel.dart';
import 'package:flutter/material.dart';

import 'package:ecommerce/screens/HomeScreen.dart';
import 'package:scoped_model/scoped_model.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<UserModel>(
      // Todos os widgets abaixo do UserModel
      // terão acesso a ele e serão mdificados se algo acontecer a ele
      model: UserModel(),
      child: ScopedModelDescendant<UserModel>(
        builder: (context, child, model) {
          return ScopedModel<CartModel>(
            // o cartmodel tera acesso ao usuario pois esta declarado abaixo
            model: CartModel(model),
            child: MaterialApp(
              title: 'E-Commerce',
              theme: ThemeData(
                primarySwatch: Colors.blue,
                primaryColor: Colors.cyan[400],
              ),
              debugShowCheckedModeBanner: false,
              home: HomeScreen(),
            ),
          );
        },
      ),
    );
  }
}
