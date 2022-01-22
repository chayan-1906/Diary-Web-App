import 'package:diary_web_app/screens/main_screen.dart';
import 'package:diary_web_app/services/diary_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'input_decorator.dart';

class CreateAccountForm extends StatelessWidget {
  const CreateAccountForm({
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
          const Text(
            'Please enter a valid email and password',
            style: TextStyle(
              fontFamily: 'ArialRounded',
              fontWeight: FontWeight.bold,
            ),
          ),
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
                String email = _emailController.text;
                FirebaseAuth.instance
                    .createUserWithEmailAndPassword(
                  email: email,
                  password: _passwordController.text,
                )
                    .then((value) async {
                  if (value.user != null) {
                    String uid = value.user.uid;
                    print(uid);
                    DiaryService()
                        .createUser(
                      context: context,
                      uid: uid,
                      displayName: email.split('@')[0],
                    )
                        .then((value) {
                      DiaryService()
                          .loginUser(
                        email: email,
                        password: _passwordController.text,
                      )
                          .then((value) {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const MainScreen()));
                      });
                    });
                  }
                });
              }
            },
            icon: const Icon(Icons.login_rounded),
            label: const Text(
              'Create Account',
              style: TextStyle(
                fontFamily: 'ArialRounded',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
