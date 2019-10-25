import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Criar conta'),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16),
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(hintText: 'Nome completo'),
              validator: (text) {
                if (text.isEmpty) return 'Nome invalido';
              },
            ),
            SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(hintText: 'Email'),
              keyboardType: TextInputType.emailAddress,
              validator: (text) {
                if (text.isEmpty || !text.contains('@'))
                  return 'Email invalido';
              },
            ),
            SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(hintText: 'Senha'),
              obscureText: true,
              validator: (text) {
                if (text.isEmpty || text.length < 6) return 'Senha invalida';
              },
            ),
            SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(hintText: 'Endereço'),
              obscureText: true,
              validator: (text) {
                if (text.isEmpty) return 'Endereço invalida';
              },
            ),
            SizedBox(height: 16),
            SizedBox(
              height: 44,
              child: RaisedButton(
                onPressed: () {
                  if (_formKey.currentState.validate()) {}
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
      ),
    );
  }
}
