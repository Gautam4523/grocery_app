import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyA4OY26e44QbjozrGkAxjoG4tKY4I_8Y0w",
      appId: "1:981178033736:android:3956644336097ae839da7d",
      messagingSenderId: "981178033736",
      projectId: "grocery-app-69c50",
      storageBucket: "com.example.grocery_app",
    ),
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginScreen(),
    );
  }
}
