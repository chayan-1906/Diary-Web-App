import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'input_decorator.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    Key key,
    @required TextEditingController emailController,
    @required TextEditingController passwordController,
    GlobalKey<FormState> formKey,
  })  : _emailController = emailController,
        _passwordController = passwordController,
        _formKey = formKey,
        super(key: key);

  final TextEditingController _emailController;
  final TextEditingController _passwordController;
  final GlobalKey<FormState> _formKey;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // email textformfield
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextFormField(
              controller: _emailController,
              decoration: buildInputDecoration(
                labelText: 'Email',
                hintText: 'abc@gmail.com',
              ),
              validator: (value) {
                return value.isEmpty ? 'Please enter an email' : null;
              },
            ),
          ),
          // password textformfield
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextFormField(
              controller: _passwordController,
              obscureText: true,
              decoration: buildInputDecoration(
                labelText: 'Password',
                hintText: '',
              ),
              validator: (value) {
                return value.isEmpty ? 'Please enter password' : null;
              },
            ),
          ),
          const SizedBox(height: 20.0),
          TextButton.icon(
            style: TextButton.styleFrom(
              primary: Colors.white,
              backgroundColor: Theme.of(context).primaryColorDark,
              padding: const EdgeInsets.all(15.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.0),
              ),
              textStyle: const TextStyle(
                fontFamily: 'ArialRounded',
                fontSize: 19.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () {
              if (_formKey.currentState.validate()) {
                print('All is good');
              }
            },
            icon: Icon(Icons.login_rounded),
            label: Text('Sign in'),
          ),
        ],
      ),
    );
  }
}
