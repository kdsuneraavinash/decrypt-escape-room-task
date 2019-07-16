import 'package:flutter/material.dart';

import '../logic/chat_responder.dart';

class ChatMessageWidget extends StatelessWidget {
  ChatMessageWidget({
    this.chatMessage,
  });

  final ChatMessage chatMessage;

  @override
  Widget build(BuildContext context) {
    if (chatMessage.isSolution) return escapeCode(chatMessage.message);

    Alignment messageAlignment =
        chatMessage.isResponse ? Alignment.centerLeft : Alignment.centerRight;
    Color bubbleColor =
        chatMessage.isResponse ? Colors.white : Colors.greenAccent;
    BorderRadius borderRadius = chatMessage.isResponse
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
    Color readCheckColor = chatMessage.delivered ? Colors.blue : Colors.black38;
    IconData readCheckIcon =
        chatMessage.delivered ? Icons.done_all : Icons.done;

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
              child: Text(chatMessage.message),
            ),
            Positioned(
              bottom: 0.0,
              right: 0.0,
              child: Row(
                children: <Widget>[
                  Text(chatMessage.time,
                      style: TextStyle(
                        color: Colors.black38,
                        fontSize: 10.0,
                      )),
                  SizedBox(width: 3.0),
                  if (!chatMessage.isResponse)
                    Icon(
                      readCheckIcon,
                      size: 12.0,
                      color: readCheckColor,
                    )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget escapeCode(String imageUrl) {
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
}
