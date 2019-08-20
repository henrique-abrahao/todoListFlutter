import 'package:flutter/material.dart';

import 'HomeList.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo',
      debugShowCheckedModeBanner: false,
      home: Lista(),
      theme: ThemeData( accentColor: Colors.greenAccent),

    );
  }
}
