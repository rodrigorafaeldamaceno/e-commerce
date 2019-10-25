import 'package:ecommerce/models/UserModel.dart';
import 'package:ecommerce/screens/RegisterScreen.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final _passController = TextEditingController();
  final _emailController = TextEditingController();

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  void _onSucces() {
    Navigator.of(context).pop();
  }

  void _onFailed() {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text('Falha ao criar usuário'),
      backgroundColor: Colors.redAccent,
      duration: Duration(seconds: 2),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text('Entrar'),
          centerTitle: true,
          actions: <Widget>[
            FlatButton(
              child: Text(
                'Criar conta',
                style: TextStyle(fontSize: 15),
              ),
              textColor: Colors.white,
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => RegisterScreen()));
              },
            )
          ],
        ),
        body: ScopedModelDescendant<UserModel>(
          builder: (context, child, model) {
            if (model.isLoading)
              return Center(child: CircularProgressIndicator());
            return Form(
              key: _formKey,
              child: ListView(
                padding: EdgeInsets.all(16),
                children: <Widget>[
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(hintText: 'Email'),
                    keyboardType: TextInputType.emailAddress,
                    validator: (text) {
                      if (text.isEmpty || !text.contains('@'))
                        return 'Email invalido';
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _passController,
                    decoration: InputDecoration(hintText: 'Senha'),
                    obscureText: true,
                    validator: (text) {
                      if (text.isEmpty || text.length < 6)
                        return 'Senha invalida';
                    },
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: FlatButton(
                      onPressed: () {
                        if (_emailController.text.isEmpty) {
                          _scaffoldKey.currentState.showSnackBar(SnackBar(
                            content: Text('Insira seu email'),
                            backgroundColor: Colors.redAccent,
                            duration: Duration(seconds: 2),
                          ));
                        } else {
                          model.recoverPas(_emailController.text);
                          _scaffoldKey.currentState.showSnackBar(SnackBar(
                            content: Text('Confira seu email'),
                            backgroundColor: Theme.of(context).primaryColor,
                            duration: Duration(seconds: 2),
                          ));
                        }
                      },
                      child: Text(
                        'Esqueci minha senha',
                        textAlign: TextAlign.right,
                      ),
                      padding: EdgeInsets.zero,
                    ),
                  ),
                  SizedBox(height: 16),
                  SizedBox(
                    height: 44,
                    child: RaisedButton(
                      child: Text(
                        'Entrar',
                        style: TextStyle(fontSize: 18),
                      ),
                      textColor: Colors.white,
                      color: Theme.of(context).primaryColor,
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          model.signIn(
                            email: _emailController.text,
                            pass: _passController.text,
                            onSucces: _onSucces,
                            onFailed: _onFailed,
                          );
                        }
                      },
                    ),
                  )
                ],
              ),
            );
          },
        ));
  }
}
