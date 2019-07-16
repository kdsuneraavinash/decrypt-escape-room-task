import '../logic/chat_responder.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'chat_message_widget.dart';
import 'chat_textbox.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<ChatMessage> chatMessages =
        Provider.of<ChatResponder>(context).chatMessages;

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
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Align(
                alignment: Alignment.topCenter,
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  reverse: true,
                  itemCount: chatMessages.length,
                  itemBuilder: (context, index) => ChatMessageWidget(
                    chatMessage: chatMessages[chatMessages.length - 1 - index],
                  ),
                ),
              ),
            ),
            ChatTextBox()
          ],
        ),
      ),
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
