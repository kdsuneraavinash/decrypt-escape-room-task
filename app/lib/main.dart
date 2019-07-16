import 'package:flutter/material.dart';

import 'progress_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Service Station',
      theme: ThemeData(
        primaryColor: Colors.white,
        accentColor: Colors.white,
        textTheme: TextTheme(
          // List Tile Subtitle
          caption: TextStyle(color: Colors.white, fontWeight: FontWeight.w200),
          // List Tile Heading
          subhead: TextStyle(fontWeight: FontWeight.w800),
        ),
      ),
      home: ProgressScreen(),
    );
  }
}
