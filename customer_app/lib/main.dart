import 'package:customer_app/views/introduction/introduction_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  setOrientations();
  runApp(const MyApp());
}

void setOrientations() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
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
