import '../logic/chat_responder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatTextBox extends StatefulWidget {
  @override
  _ChatTextBoxState createState() => _ChatTextBoxState();
}

class _ChatTextBoxState extends State<ChatTextBox> {
  TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Flexible(
            child: Container(
              child: TextField(
                controller: _textController,
                style: TextStyle(fontSize: 15.0),
                decoration: InputDecoration.collapsed(
                  hintText: 'Type your message...',
                ),
              ),
            ),
          ),
          Material(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 8.0),
              child: IconButton(
                icon: Icon(Icons.send),
                onPressed: () {
                  Provider.of<ChatResponder>(context)
                      .recieveMessage(_textController.text);
                  setState(() {
                    _textController.text = "";
                  });
                },
              ),
            ),
            color: Colors.white,
          ),
        ],
      ),
      width: double.infinity,
      height: 50.0,
      decoration: BoxDecoration(
          border: Border(top: BorderSide(width: 0.5, color: Colors.grey)),
          color: Colors.white),
    );
  }
}
