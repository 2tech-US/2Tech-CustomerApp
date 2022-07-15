import 'package:customer_app/views/authenticate/login_page.dart';
import 'package:customer_app/views/introduction/introduction_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '2Tech',
      theme: ThemeData(
        
        primarySwatch: Colors.blue,
      ),
      home: const IntroductionPage(),
    );
  }
}