import 'package:app/chat_screen.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class ProgressScreen extends StatefulWidget {
  @override
  _ProgressScreenState createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  String animation = "Loading";

  @override
  void initState() {
    super.initState();
    changeAnimation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: MediaQuery.of(context).size.width * 0.6,
          width: MediaQuery.of(context).size.width * 0.6,
          child: FlareActor(
            "assets/progress.flr",
            animation: animation,
            color: Colors.blueGrey[800],
          ),
        ),
      ),
    );
  }

  void changeAnimation() async {
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      animation = "Success";
    });

    await Future.delayed(Duration(seconds: 3));
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, _) => FadeTransition(
          opacity: animation,
          child: ChatScreen(),
        ),
      ),
    );
  }
}
