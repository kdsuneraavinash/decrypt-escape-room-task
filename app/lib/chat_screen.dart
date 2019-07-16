import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade50,
      appBar: AppBar(
        elevation: 1,
        title: Text(
          'Service Center',
          style: TextStyle(color: Colors.green),
        ),
        leading: Icon(
          FontAwesomeIcons.robot,
          color: Colors.green,
        ),
        actions: <Widget>[
          uselessButton(Icons.videocam),
          uselessButton(Icons.call),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            responseMessage(
              message:
                  'Hi... This is an automated message.\nCan you please enter your team name to validate your entry?',
              time: '12:00',
            ),
            readMyMessage(
              message: 'Team ODSDF',
              time: '12:01',
            ),
            responseMessage(
              message: "I'm sorry. The team name is not registered.",
              time: '12:00',
            ),
            responseMessage(
              message: "Please re-enter your team name.",
              time: '12:00',
            ),
            readMyMessage(
              message: 'Team NANE',
              time: '12:00',
            ),
            responseMessage(
              message: 'Team found... Registering team name...',
              time: '12:01',
            ),
            responseMessage(
              message: 'Record ERREORO',
              time: '12:01',
            ),
            responseMessage(
              message:
                  'Please enter the time you enetered the building to confirm your identity (Format HH:MM)',
              time: '12:01',
            ),
            readMyMessage(
              message: '8:00',
              time: '12:00',
            ),
            responseMessage(
              message: 'Record Mismatch... Please re-enter time.',
              time: '12:01',
            ),
            readMyMessage(
              message: '12:30',
              time: '12:00',
            ),
            responseMessage(
              message: 'Record Matched.',
              time: '12:01',
            ),
            responseMessage(
              message: 'Your code is sent.',
              time: '12:01',
            ),
            escapeCode(),
          ],
        ),
      ),
    );
  }

  Widget readMyMessage({String message, String time}) {
    return ChatMessage(
      message: message,
      time: time,
      delivered: true,
      isResponse: false,
    );
  }

  Widget unreadMyMessage({String message, String time}) {
    return ChatMessage(
      message: message,
      time: time,
      delivered: false,
      isResponse: false,
    );
  }

  Widget responseMessage({String message, String time}) {
    return ChatMessage(
      message: message,
      time: time,
      delivered: true,
      isResponse: true,
    );
  }

  Widget escapeCode() {
    return Container(
      margin: EdgeInsets.all(4),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurRadius: 1,
            spreadRadius: 1,
            color: Color(0x22000000),
          )
        ],
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(5.0),
          bottomLeft: Radius.circular(10.0),
          bottomRight: Radius.circular(5.0),
        ),
        image: DecorationImage(
          image: NetworkImage(
              "https://images.pexels.com/photos/414612/pexels-photo-414612.jpeg"),
          fit: BoxFit.cover,
        ),
      ),
      height: 200,
    );
  }

  Widget uselessButton(IconData icon) {
    return Builder(
      builder: (context) => IconButton(
        icon: Icon(
          icon,
          color: Colors.green,
        ),
        onPressed: () {
          showDialog(context: context, builder: (context) => ErrorDialogBox());
        },
      ),
    );
  }
}

class ChatMessage extends StatelessWidget {
  ChatMessage({
    this.message,
    this.time,
    this.delivered,
    this.isResponse,
  });

  final String message;
  final String time;
  final bool delivered;
  final bool isResponse;

  @override
  Widget build(BuildContext context) {
    Alignment messageAlignment =
        isResponse ? Alignment.centerLeft : Alignment.centerRight;
    Color bubbleColor = isResponse ? Colors.white : Colors.greenAccent;
    BorderRadius borderRadius = isResponse
        ? BorderRadius.only(
            topRight: Radius.circular(5.0),
            bottomLeft: Radius.circular(10.0),
            bottomRight: Radius.circular(5.0),
          )
        : BorderRadius.only(
            topLeft: Radius.circular(5.0),
            bottomLeft: Radius.circular(5.0),
            bottomRight: Radius.circular(10.0),
          );

    return Align(
      alignment: messageAlignment,
      child: Container(
        margin: EdgeInsets.all(4),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              blurRadius: 1,
              spreadRadius: 1,
              color: Color(0x22000000),
            )
          ],
          color: bubbleColor,
          borderRadius: borderRadius,
        ),
        child: Stack(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 48.0),
              child: Text(message),
            ),
            Positioned(
              bottom: 0.0,
              right: 0.0,
              child: Row(
                children: <Widget>[
                  Text(time,
                      style: TextStyle(
                        color: Colors.black38,
                        fontSize: 10.0,
                      )),
                  SizedBox(width: 3.0),
                  if (!isResponse)
                    Icon(
                      delivered ? Icons.done_all : Icons.done,
                      size: 12.0,
                      color: Colors.black38,
                    )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ErrorDialogBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text("Network Unstable.\nConnection cannot be established."),
      actions: <Widget>[
        RaisedButton(
          color: Colors.red,
          child: Text("OK"),
          onPressed: () {
            Navigator.pop(context);
          },
        )
      ],
    );
  }
}
