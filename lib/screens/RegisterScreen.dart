import 'package:ecommerce/models/UserModel.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _passController = TextEditingController();
  final _addresController = TextEditingController();
  final _emailController = TextEditingController();

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  void _onSucces() {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text('Usuário criado com sucesso'),
      backgroundColor: Theme.of(context).primaryColor,
      duration: Duration(seconds: 2),
    ));
    Future.delayed(Duration(seconds: 2)).then((_) {
      Navigator.of(context).pop();
    });
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
          title: Text('Criar conta'),
          centerTitle: true,
        ),
        body: ScopedModelDescendant<UserModel>(
          builder: (context, child, model) {
            if (model.isLoading)
              return Center(
                child: CircularProgressIndicator(),
              );
            return Form(
              key: _formKey,
              child: ListView(
                padding: EdgeInsets.all(16),
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(hintText: 'Nome completo'),
                    validator: (text) {
                      if (text.isEmpty) return 'Nome invalido';
                    },
                    controller: _nameController,
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    decoration: InputDecoration(hintText: 'Email'),
                    keyboardType: TextInputType.emailAddress,
                    validator: (text) {
                      if (text.isEmpty || !text.contains('@'))
                        return 'Email invalido';
                    },
                    controller: _emailController,
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    decoration: InputDecoration(hintText: 'Senha'),
                    obscureText: true,
                    validator: (text) {
                      if (text.isEmpty || text.length < 6)
                        return 'Senha invalida';
                    },
                    controller: _passController,
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    decoration: InputDecoration(hintText: 'Endereço'),
                    validator: (text) {
                      if (text.isEmpty) return 'Endereço invalida';
                    },
                    controller: _addresController,
                  ),
                  SizedBox(height: 16),
                  SizedBox(
                    height: 44,
                    child: RaisedButton(
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          Map<String, dynamic> userData = {
                            'name': _nameController.text,
                            'email': _emailController.text,
                            'addres': _addresController.text
                          };
                          model.signUp(
                              userData: userData,
                              onFailed: _onFailed,
                              onSuccess: _onSucces,
                              pass: _passController.text);
                        }
                      },
                      child: Text(
                        'Criar Conta',
                        style: TextStyle(fontSize: 18),
                      ),
                      textColor: Colors.white,
                      color: Theme.of(context).primaryColor,
                    ),
                  )
                ],
              ),
            );
          },
        ));
  }
}
