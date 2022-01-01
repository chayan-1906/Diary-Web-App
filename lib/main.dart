import 'package:diary_web_app/screens/get_started_screen.dart';
import 'package:diary_web_app/screens/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyBtYPX74GrlITMMw-NYMpUyo8uG2laRVoQ", // Your apiKey
      appId: "1:849635522195:web:f78c289ea8dee4d419ff66", // Your appId
      messagingSenderId: "849635522195", // Your messagingSenderId
      projectId: "diary-web-app-chayan19062000", // Your projectId
    ),
  );
  WidgetsFlutterBinding.ensureInitialized();
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
      home: const LoginScreen(),
    );
  }
}
