import 'package:diary_web_app/screens/get_started_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Diary Book',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primarySwatch: Colors.green,
        primaryColor: Colors.greenAccent,
        // appBarTheme: AppBarTheme(color: Colors.greenAccent),
      ),
      home: const GettingStartedPage(),
    );
  }
}
