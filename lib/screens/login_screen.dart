import 'package:diary_web_app/widgets/create_account_form.dart';
import 'package:diary_web_app/widgets/login_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isCreateAccountClicked = false;

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
                  child: isCreateAccountClicked
                      ? CreateAccountForm(
                          emailController: _emailController,
                          passwordController: _passwordController,
                          formKey: _formKey,
                        )
                      : LoginForm(
                          emailController: _emailController,
                          passwordController: _passwordController,
                          formKey: _formKey,
                        ),
                ),
                TextButton.icon(
                  onPressed: () {
                    setState(() {
                      isCreateAccountClicked = !isCreateAccountClicked;
                      // if (isCreateAccountClicked) {
                      //   isCreateAccountClicked = false;
                      // } else {
                      //   isCreateAccountClicked = true;
                      // }
                    });
                  },
                  icon: Icon(Icons.portrait_rounded, color: Colors.deepOrange),
                  label: Text(
                    isCreateAccountClicked
                        ? 'Already have an account?'
                        : 'Create Account',
                    style: const TextStyle(
                      fontFamily: 'ArialRounded',
                      fontSize: 18.0,
                      color: Colors.deepOrange,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
                const SizedBox(height: 15.0),
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
