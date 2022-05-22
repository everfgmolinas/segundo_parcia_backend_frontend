import 'package:flutter/material.dart';
import 'package:segundo_parcia_backend/pages/home.dart';

import 'constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: mesaTheme,
      home: const MyHomePage(title: 'Restaurant'),
    );
  }
}
