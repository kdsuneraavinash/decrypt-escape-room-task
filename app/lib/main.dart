import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'logic/chat_responder.dart';
import 'progress_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (context) => ChatResponder(),
      child: MaterialApp(
        title: 'Service Station',
        theme: ThemeData(
          primaryColor: Colors.white,
          accentColor: Colors.white,
          textTheme: TextTheme(
            // List Tile Subtitle
            caption:
                TextStyle(color: Colors.white, fontWeight: FontWeight.w200),
            // List Tile Heading
            subhead: TextStyle(fontWeight: FontWeight.w800),
          ),
        ),
        home: ProgressScreen(),
      ),
    );
  }
}
