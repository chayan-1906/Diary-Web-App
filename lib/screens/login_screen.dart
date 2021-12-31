import 'package:diary_web_app/widgets/login_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 2,
              child: Container(
                color: const Color(0xFFB9C2D1),
              ),
            ),
            const SizedBox(height: 10.0),
            Text(
              'Sign in',
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  .copyWith(fontFamily: 'ArialRounded'),
            ),
            const SizedBox(height: 10.0),
            Column(
              children: [
                SizedBox(
                  width: 300.0,
                  height: 300.0,
                  child: LoginForm(
                    emailController: _emailController,
                    passwordController: _passwordController,
                    formKey: _formKey,
                  ),
                ),
              ],
            ),
            Expanded(
              flex: 2,
              child: Container(
                color: const Color(0xFFB9C2D1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
