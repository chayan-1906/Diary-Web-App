import 'package:flutter/material.dart';

import 'login_screen.dart';

class GettingStartedPage extends StatelessWidget {
  const GettingStartedPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: CircleAvatar(
        backgroundColor: Color(0xFFF5F6F8),
        child: Column(
          children: [
            Spacer(),
            Text(
              'DiaryBook',
              style: Theme.of(context).textTheme.headline3,
            ),
            SizedBox(height: 40.0),
            Text(
              '"Document your life"',
              style: TextStyle(
                fontFamily: 'ArialRounded',
                fontSize: 29.0,
                color: Colors.black26,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 50.0),
            Container(
              // width: 220.0,
              height: 40.0,
              child: TextButton.icon(
                style: TextButton.styleFrom(
                  textStyle: const TextStyle(
                    fontFamily: 'ArialRounded',
                    fontSize: 19.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(),
                    ),
                  );
                },
                icon: const Icon(Icons.login_rounded),
                label: const Text('Sign in to Get Started'),
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
